#!/usr/bin/env bash

# 设置bag包路径
path="./Bag"
# 设置bag包名称
rbag="hall.bag"

# 定义一个清理函数，用于终止由roslaunch启动的所有进程
cleanup() {
    echo "Caught interrupt signal. Cleaning up..."
    # 使用pkill终止所有由roslaunch启动的进程
    pkill -INT -f "roslaunch livox_camera_calib calib.launch"
}
# 设置trap，按Ctrl+C，执行cleanup函数
trap cleanup INT

# 切换到catkin_ws目录并设置环境变量，然后启动ROS launch文件
cd ..
cd ./catkin_ws
catkin_make
source ~/catkin_ws/devel/setup.bash
roslaunch fast_livo mapping_avia.launch &

# 等待一段时间确保上一个命令已经开始执行
sleep 5

# 在新的终端中执行剩余的命令
gnome-terminal -- bash -c "cd ..; cd '$path'; rosbag play '$rbag'; exec bash"
xdotool windowactivate --sync $(xdotool getactivewindow)

# 记录roslaunch的PID，以便在需要时直接终止（可选）
roslaunch_pid=$!

# 等待roslaunch进程结束.
while kill -0 $roslaunch_pid > /dev/null 2>&1; do
    sleep 1
done

# 给txt文件添加可执行权限
chmod +x /home/kilimy/Bag/odom/fastlivo_odom.txt
