#!/bin/bash
# HDF5文件合并脚本
# 自动合并当前目录下的HDF5拆分文件

# 自动查找拆分文件
PART1=$(ls PBG08621_pass_6c7986d6_167483a9_0_part1.hdf5 2>/dev/null)
PART2=$(ls PBG08621_pass_6c7986d6_167483a9_0_part2.hdf5 2>/dev/null)
PART3=$(ls PBG08621_pass_6c7986d6_167483a9_0_part3.hdf5 2>/dev/null)
PART4=$(ls PBG08621_pass_6c7986d6_167483a9_0_part4.hdf5 2>/dev/null)
OUTPUT_FILE="PBG08621_pass_6c7986d6_167483a9_0.hdf5"

# 检查拆分文件是否存在
if [ -z "$PART1" ] || [ ! -f "$PART1" ]; then
    echo "错误: 找不到文件 PBG08621_pass_6c7986d6_167483a9_0_part1.hdf5"
    exit 1
fi

if [ -z "$PART2" ] || [ ! -f "$PART2" ]; then
    echo "错误: 找不到文件 PBG08621_pass_6c7986d6_167483a9_0_part2.hdf5"
    exit 1
fi

if [ -z "$PART3" ] || [ ! -f "$PART3" ]; then
    echo "错误: 找不到文件 PBG08621_pass_6c7986d6_167483a9_0_part3.hdf5"
    exit 1
fi

if [ -z "$PART4" ] || [ ! -f "$PART4" ]; then
    echo "错误: 找不到文件 PBG08621_pass_6c7986d6_167483a9_0_part4.hdf5"
    exit 1
fi

echo "找到拆分文件:"
echo "  - $PART1 ($(du -h "$PART1" | cut -f1))"
echo "  - $PART2 ($(du -h "$PART2" | cut -f1))"
echo "  - $PART3 ($(du -h "$PART3" | cut -f1))"
echo "  - $PART4 ($(du -h "$PART4" | cut -f1))"

# 合并文件
echo "正在合并文件..."
cat "$PART1" "$PART2" "$PART3" "$PART4" > "$OUTPUT_FILE"

# 检查合并结果
if [ $? -eq 0 ]; then
    echo "合并完成! 输出文件: $OUTPUT_FILE"
    echo "文件大小: $(du -h "$OUTPUT_FILE" | cut -f1)"
    
    echo "✅ 合并成功!"
else
    echo "❌ 合并失败!"
    exit 1
fi
