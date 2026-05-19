import type { AudioResult, AudioTag, Config, TranscriptionSegment } from "../types.js";
import { extractAudio } from "../extractors/audio.js";
import { type SilenceDetector } from "../extractors/audio-chunker.js";
import { getVideoMetadata } from "../extractors/frames.js";
interface GenAiFile {
    name?: string;
    state?: string;
    uri?: string;
    mimeType?: string;
}
interface GenAiFilesApi {
    get(args: {
        name: string;
    }): Promise<GenAiFile>;
    delete(args: {
        name: string;
    }): Promise<void>;
}
interface GenAiClient {
    files: GenAiFilesApi;
}
interface WaitForFileActiveOptions {
    timeoutMs?: number;
    pollIntervalMs?: number;
}
export declare function waitForFileActive(ai: GenAiClient, file: GenAiFile, options?: WaitForFileActiveOptions): Promise<GenAiFile>;
interface ParsedGeminiAudio {
    transcription: TranscriptionSegment[];
    audio_tags: AudioTag[];
}
export declare function parseGeminiAudioResponse(raw: string): ParsedGeminiAudio;
export declare function transcribeChunk(wavPath: string, offsetSec: number, config: Config): Promise<{
    segments: TranscriptionSegment[];
    tags: AudioTag[];
}>;
export interface ChunkResult {
    ok: boolean;
    attempt: number;
    segments?: TranscriptionSegment[];
    tags?: AudioTag[];
    error?: string;
}
export type TranscribeWorker = (wavPath: string, offsetSec: number, config: Config) => Promise<{
    segments: TranscriptionSegment[];
    tags: AudioTag[];
}>;
export type WarningEmitter = (w: {
    event: "retry";
    attempt: number;
    error: string;
}) => void;
export declare function transcribeChunkWithRetry(wavPath: string, offsetSec: number, config: Config, retries: number, worker?: TranscribeWorker, onWarning?: WarningEmitter): Promise<ChunkResult>;
export interface AudioSlice {
    startTime?: string;
    endTime?: string;
}
export interface AnalyzeDeps {
    getMetadata?: typeof getVideoMetadata;
    extract?: typeof extractAudio;
    worker?: TranscribeWorker;
    silenceDetector?: SilenceDetector;
}
export declare function analyzeWithGeminiApi(videoPath: string, config: Config, slice?: AudioSlice, deps?: AnalyzeDeps): Promise<AudioResult>;
export {};
