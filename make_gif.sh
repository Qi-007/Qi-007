#!/bin/bash

# 自动将 Processing 保存的帧转换为 GIF
# 使用方法: ./make_gif.sh

set -e

# 配置
FRAMES_DIR="frames"
INPUT_PATTERN="frame%04d.png"
OUTPUT_FILE="output.gif"
FRAME_RATE=20
WIDTH=""  # 留空为原始大小，例如 "960" 表示宽度 960，高度自动

echo "🎬 Converting frames to GIF..."
echo "   Frames directory: $FRAMES_DIR"
echo "   Output file: $OUTPUT_FILE"
echo "   Frame rate: $FRAME_RATE fps"

# 检查 frames 目录是否存在
if [ ! -d "$FRAMES_DIR" ]; then
    echo "❌ Error: '$FRAMES_DIR' directory not found!"
    echo "   Make sure saveFrames is set to true in the .pde file and run it first."
    exit 1
fi

# 检查是否有帧文件
FRAME_COUNT=$(ls -1 "$FRAMES_DIR"/*.png 2>/dev/null | wc -l)
if [ "$FRAME_COUNT" -eq 0 ]; then
    echo "❌ Error: No PNG frames found in '$FRAMES_DIR'!"
    exit 1
fi

echo "   Found $FRAME_COUNT frames"
echo ""

# 构建 ffmpeg 命令
FFMPEG_CMD="ffmpeg -framerate $FRAME_RATE -i $FRAMES_DIR/$INPUT_PATTERN"

# 添加缩放（如果指定了宽度）
if [ -n "$WIDTH" ]; then
    FFMPEG_CMD="$FFMPEG_CMD -vf \"scale=$WIDTH:-1\""
fi

# 添加调色板处理以获得最佳 GIF 质量
FFMPEG_CMD="$FFMPEG_CMD -filter_complex \"split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse\" $OUTPUT_FILE"

# 执行转换
echo "⏳ Running ffmpeg..."
eval $FFMPEG_CMD

echo ""
echo "✅ Done! GIF saved to: $OUTPUT_FILE"
echo ""
echo "   File size:"
ls -lh "$OUTPUT_FILE" | awk '{print "   " $5}'
