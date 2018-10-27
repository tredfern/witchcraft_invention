-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local randomly = {}

function randomly.choose(tbl)
  return tbl[math.random(#tbl)]
end


return randomly
