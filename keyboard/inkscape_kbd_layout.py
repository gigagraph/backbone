# TODO: copy prototype
# TODO: draw rectangles with all the letters, symbols, and numbers
# TODO: arrange them
from typing import TYPE_CHECKING

if TYPE_CHECKING:
  from simpinkscr import *
  from simpinkscr.simple_inkscape_scripting import SimpleCanvas, SimpleGroup

canvas: SimpleCanvas

proto_shapes = [
  s
  for s in selected_shapes()
  if type(s) == SimpleGroup and
    s.get_inkex_object().label == "Prototype"
]

proto_shape = None if len(proto_shapes) == 0 else proto_shapes[0]

if proto_shape:
  # proto_copy = duplicate(proto_shape, transform=f"translate({15 + 10}, 0)")
  print(proto_shape.get_inkex_object())
else:
  print("Proto shape is not selected")
