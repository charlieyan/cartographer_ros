-- Otherlab, Inc ("COMPANY") CONFIDENTIAL
-- Unpublished Copyright (c) 2014-2015 Otherlab, Inc, All Rights Reserved.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  -- The ROS frame ID to use for publishing submaps,
  -- the parent frame of poses, usually “map”.
  tracking_frame = "base_link",
  -- The ROS frame ID of the frame that is tracked by the SLAM algorithm.
  -- If an IMU is used, it should be at its position,
  -- although it might be rotated. A common choice is “imu_link”.
  published_frame = "base_link",
  -- The ROS frame ID to use as the child frame for publishing poses.
  -- For example “odom” if an “odom” frame is supplied by a different part of the system.
  -- In this case the pose of “odom” in the map_frame will be published.
  -- Otherwise, setting it to “base_link” is likely appropriate.
  provide_odom_frame = true,
  -- If enabled, the local, non-loop-closed,
  -- continuous pose will be published as the odom_frame in the map_frame.
  odom_frame = "odom",
  -- Only used if provide_odom_frame is true.
  -- The frame between published_frame and
  -- map_frame to be used for publishing
  -- the (non-loop-closed) local SLAM result. Usually “odom”.
  use_odometry = false,
  -- If enabled, subscribes to nav_msgs/Odometry on the topic “odom”.
  -- Odometry must be provided in this case, and the information will be included in SLAM.
  num_laser_scans = 0,
  -- Number of laser scan topics to subscribe to.
  -- Subscribes to sensor_msgs/LaserScan on the “scan”
  -- topic for one laser scanner, or topics “scan_1”, “scan_2”, etc.
  -- for multiple laser scanners.
  num_multi_echo_laser_scans = 0,
  -- Number of multi-echo laser scan topics to subscribe to.
  -- Subscribes to sensor_msgs/MultiEchoLaserScan on the “echoes”
  -- topic for one laser scanner, or topics “echoes_1”,
  -- “echoes_2”, etc. for multiple laser scanners.
  num_subdivisions_per_laser_scan = 10,
  -- Number of point clouds to split each received (multi-echo)
  -- laser scan into. Subdividing a scan makes it possible
  -- to unwarp scans acquired while the scanners are moving.
  -- There is a corresponding trajectory builder option
  -- to accumulate the subdivided scans into
  -- a point cloud that will be used for scan matching.
  num_point_clouds = 1,
  -- Number of point cloud topics to subscribe to.
  -- Subscribes to sensor_msgs/PointCloud2 on the “points2”
  -- topic for one rangefinder, or topics “points2_1”,
  -- “points2_2”, etc. for multiple rangefinders.
  lookup_transform_timeout_sec = 0.2,
  -- Timeout in seconds to use for looking up transforms using tf2.
  submap_publish_period_sec = 0.3,
  -- Interval in seconds at which to publish the submap poses, e.g. 0.3 seconds.
  pose_publish_period_sec = 5e-3,
  -- Interval in seconds at which to publish poses, e.g. 5e-3 for a frequency of 200 Hz.
  trajectory_publish_period_sec = 30e-3,
  -- Interval in seconds at which to publish the trajectory markers, e.g. 30e-3 for 30 milliseconds.
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  use_nav_sat = false,
  fixed_frame_pose_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true

TRAJECTORY_BUILDER_2D.min_range = 0.1
TRAJECTORY_BUILDER_2D.max_range = 8.
TRAJECTORY_BUILDER_2D.missing_data_ray_length = 5.
TRAJECTORY_BUILDER_2D.use_imu_data = false
TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true
TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians = math.rad(0.1)

return options
