import type { ChunkPlan, ChunkWarning, Config, Interval } from "../types.js";
export type SilenceThreshold = "default" | "loose";
export type SilenceDetector = (videoPath: string, threshold: SilenceThreshold) => Promise<Interval[]>;
export declare function detectSilencesReal(videoPath: string, threshold: SilenceThreshold): Promise<Interval[]>;
export declare function planChunks(videoPath: string, durationSec: number, config: Config, detector?: SilenceDetector): Promise<{
    chunks: ChunkPlan[];
    warnings: ChunkWarning[];
}>;
