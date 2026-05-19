export interface ExtractAudioOptions {
    startTime?: string;
    endTime?: string;
    filename?: string;
}
export declare function buildExtractArgs(videoPath: string, outputPath: string, options: ExtractAudioOptions): string[];
export declare function extractAudio(videoPath: string, outputDir: string, options?: ExtractAudioOptions): Promise<string>;
