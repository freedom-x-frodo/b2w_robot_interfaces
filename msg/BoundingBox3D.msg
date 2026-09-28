# One 3D bounding box fitted to a cluster of LiDAR returns.
#
# Yaw-only orientation, deliberately. The box is level with the frame's XY plane and
# rotated about Z alone: a full 3-DoF orientation from PCA on a single sweep is mostly
# noise, because the sensor sees one face of most objects and the vertical extent is
# whatever the beams happened to hit. Roll and pitch fitted to that are not information.
# Consumers that need a level box (costmaps, footprint checks) can use this directly;
# consumers that need a full pose should not be reading a single-sweep cluster anyway.
#
# NOT a tracked object: there is no identity across messages and `id` is per-message only.
# Nothing here has been classified -- these are clusters of points, not "people" or "cars".

# center.position is the centre of the box, not the centroid of the points -- for a
# partially observed object those differ by up to half the box extent.
# center.orientation carries the fitted yaw only (x and y components are always 0).
geometry_msgs/Pose center

# FULL extents along the box's own axes, in metres (not half-extents -- RViz/Foxglove
# CUBE markers take full extents, and half-extents are the single most common mix-up here).
geometry_msgs/Vector3 size

# Index within the containing BoundingBox3DArray. Stable only inside one message; a box
# with id 3 in the next message is not the same object. Present so a viewer can label
# boxes and a log line can name one, nothing more.
uint32 id

# Points that survived filtering and landed in this cluster. A proxy for how much evidence
# the box rests on: a 12-point box a long way off is a guess, a 4000-point box is a wall.
uint32 point_count

# Lowest and highest z of the cluster IN THE CLOUD FRAME, before the box was levelled.
# Kept because the box alone cannot answer "is this on the ground or overhead?" once the
# sensor is tilted -- useful for discarding ceiling fixtures and overhanging branches.
float32 min_z
float32 max_z
