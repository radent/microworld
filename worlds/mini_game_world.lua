
local Point3 = _radiant.csg.Point3

local MiniGame = class()

function MiniGame:start()
   -- create a tiny world
   microworld:create_world(128)

   -- embark at -2, -2
   microworld:place_town_banner(-2, -2)
   microworld:place_full_sized_entity('stonehearth:decoration:firepit', 0, 11)

   -- add some bushes so our citizens don't starve
   for x = 1,4 do
      for z = 1,2 do
         microworld:place_entity('stonehearth:berry_bush', 4 + x * 4, 2 + z * 4)
      end
   end

   -- drop some trees, too
   microworld:place_entity('stonehearth:large_oak_tree', -12, -12)
   microworld:place_entity('stonehearth:medium_oak_tree',  14, -13)
   microworld:place_entity('stonehearth:medium_oak_tree',  11,  16)
   microworld:place_entity('stonehearth:small_oak_tree', -10,  15)

   -- and a cute little fox.
   microworld:place_entity('stonehearth:red_fox', 2, 2)

   -- create all the workers.
   local workers = {}
   for x = 1,3 do
      for z = 1,2 do
         local worker = microworld:place_citizen(-5 + (x * 3), -5 + (z * 3))
         table.insert(workers, worker)
      end
   end

   -- give some of the workers some starting items.
   local player_id = microworld:get_local_player_id()
   local pop = stonehearth.population:get_population(player_id)

   local function pickup(who, uri)
      local item = pop:create_entity(uri)
      radiant.entities.pickup_item(who, item)
   end
   pickup(workers[6], 'stonehearth:resources:wood:oak_log')
   pickup(workers[2], 'stonehearth:resources:fiber:silkweed_bundle')
   pickup(workers[3], 'stonehearth:trapper:talisman')
   pickup(workers[4], 'stonehearth:carpenter:talisman')
end

return MiniGame

