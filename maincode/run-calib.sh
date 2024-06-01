#!/usr/bin/env bash

# 定义一个清理函数，用于终止由roslaunch启动的所有进程
cleanup() {
    echo "Caught interrupt signal. Cleaning up..."
    # 使用pkill终止所有由roslaunch启动的进程
    pkill -INT -f "roslaunch livox_camera_calib calib.launch"
}

# 设置trap，按Ctrl+C，执行cleanup函数
trap cleanup INT

# 脚本主体
cd ..
cd ./catkin_ws
source ~/catkin_ws/devel/setup.bash

# 启动roslaunch命令
roslaunch livox_camera_calib calib.launch &
# 记录roslaunch的PID，以便在需要时直接终止（可选）
roslaunch_pid=$!

# 等待roslaunch进程结束.
while kill -0 $roslaunch_pid > /dev/null 2>&1; do
    sleep 1
done

