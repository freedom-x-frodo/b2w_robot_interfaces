# All bounding boxes fitted to one LiDAR sweep.
#
# Published by b2w_perception's lidar_bbox node, one message per input cloud. An empty
# `boxes` array is a real, meaningful result -- "this sweep contained nothing that cleared
# the filters" -- and is published rather than suppressed, so a consumer can tell "nothing
# there" apart from "the detector died". Do not treat silence as empty.

# Stamp and frame are copied from the source cloud, so the boxes are in the LiDAR frame
# (`rslidar` on this robot) at the sweep's own time. Transform them yourself if you need
# them elsewhere; this node does not, because the useful target frame differs per consumer.
std_msgs/Header header

BoundingBox3D[] boxes

# Points in the cloud before and after filtering (crop, voxel downsample, ground removal).
# The ratio is the cheapest health signal there is: if `points_kept` collapses while
# `points_in` holds steady, the filters are eating the scene -- which looks identical to
# "empty room" if you only ever look at `boxes`.
uint32 points_in
uint32 points_kept

# Wall-clock milliseconds spent processing this cloud, measured inside the callback.
# The sensor delivers at 10 Hz, so anything approaching 100 ms means sweeps are being
# dropped and the boxes are staler than their stamp suggests.
float32 processing_ms
