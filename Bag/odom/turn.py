# -*- coding: utf-8 -*-
# 读取odom.txt的全部内容
with open('odom.txt', 'r') as file_b:
    lines = file_b.readlines()

# 获取第一行的时间戳作为基准
base_timestamp = float(lines[0].split()[0])

# 调整每一行的时间戳
adjusted_lines = []
for line in lines:
    timestamp_str, *rest = line.split()  # 分割时间戳和其他部分
    adjusted_timestamp = str(float(timestamp_str) - base_timestamp)  # 计算偏移后的时间戳
    adjusted_lines.append(adjusted_timestamp + ' ' + ' '.join(rest) + '\n')  # 重新组合行

# 写入reference.txt
with open('reference.txt', 'w') as file_c:
    file_c.writelines(adjusted_lines)

print("已将reference.txt的时间戳调整并保存至reference.txt，确保第一行时间戳从0开始")
