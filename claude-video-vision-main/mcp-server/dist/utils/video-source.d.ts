import type { AudioResult, TranscriptionSegment } from "../types.js";
export interface VideoSourceMetadata {
    type: "youtube";
    url: string;
    title?: string;
    channel?: string;
    duration?: string;
    upload_date?: string;
    view_count?: number;
    description?: string;
    caption_track?: YouTubeCaptionTrackMetadata;
}
export interface ResolvedVideoInput {
    path: string;
    source?: VideoSourceMetadata;
    captions?: YouTubeCaptionResult;
}
export interface YouTubeCaptionTrackMetadata {
    source: "subtitles" | "automatic_captions";
    language: string;
    language_name?: string;
}
export interface YouTubeCaptionResult extends YouTubeCaptionTrackMetadata {
    transcription: TranscriptionSegment[];
    coverage_seconds: number;
}
export declare function isYouTubeUrl(input: string): boolean;
export declare function validateVideoPath(inputPath: string): string;
export declare function parseSubtitleContent(raw: string): TranscriptionSegment[];
export declare function cleanExpiredDownloads(downloadsDir: string, maxAgeDays: number): void;
export declare function getTranscriptCoverageSeconds(transcription: TranscriptionSegment[]): number;
export declare function getCaptionFallbackReason(captions: YouTubeCaptionResult | undefined, durationSeconds: number): string | null;
export declare function buildCaptionAudioResult(captions: YouTubeCaptionResult, range?: {
    startTime?: string;
    endTime?: string;
}): AudioResult;
export declare function resolveVideoInputDetailed(input: string): Promise<ResolvedVideoInput>;
export declare function resolveVideoInput(input: string): Promise<string>;
export declare function getDownloadsDir(): string;
