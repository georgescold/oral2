import { z } from "zod";
import { getVideoMetadata } from "../extractors/frames.js";
import { resolveVideoInputDetailed } from "../utils/video-source.js";
export function registerVideoInfo(server) {
    server.tool("video_info", "Get metadata about a local video file or YouTube URL without processing it (duration, resolution, codec, etc.)", { path: z.string().describe("Absolute/relative path to the video file, or a YouTube URL") }, async ({ path }) => {
        const resolved = await resolveVideoInputDetailed(path);
        const metadata = await getVideoMetadata(resolved.path);
        const output = resolved.source ? { source: resolved.source, metadata } : metadata;
        return {
            content: [{ type: "text", text: JSON.stringify(output, null, 2) }],
        };
    });
}
