# -*- coding: utf-8 -*-
import numpy as np

# 原始txt文件路径
input_file_path = 'fastlivo_odom.txt'
# 输出txt文件路径
output_file_path = 'test.txt'

# 读取原始文件
with open(input_file_path, 'r') as file:
    lines = file.readlines()

# 确保至少有一行数据
if not lines:
    print("原始文件为空")
else:
    # 解析第一行获取列数
    first_line = lines[0].strip().split()
    num_columns = len(first_line)
    
    # 计算需要生成的行数
    total_lines = len(lines)
    max_time = 210  # 最大时间戳调整为210
    min_time = 0  # 最小时间戳为0
    
    # 生成新的时间戳序列，等差分布
    new_timestamps = np.linspace(min_time, max_time, total_lines, endpoint=True)
    
    with open(output_file_path, 'w') as new_file:
        for i, line in enumerate(lines):
            # 分割每一行，替换时间戳
            parts = line.strip().split()
            original_timestamp = float(parts[0])
            adjusted_timestamp = new_timestamps[i]
            
            # 保留原始行的其他列，并替换时间戳
            parts[0] = f"{adjusted_timestamp:.9f}"  # 保持9位小数精度
            new_line = ' '.join(parts) + '\n'
            new_file.write(new_line)

print(f"处理完成，结果已保存至 {output_file_path}")
