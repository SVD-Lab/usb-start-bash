import launch
import launch_ros.actions
from launch.actions import IncludeLaunchDescription
from ament_index_python.packages import get_package_share_directory
from launch.launch_description_sources import PythonLaunchDescriptionSource

def generate_launch_description():
    rclshark = launch_ros.actions.Node(
        package="rclshark", executable="rclshark"
    )

    return launch.LaunchDescription([
        rclshark
    ])
