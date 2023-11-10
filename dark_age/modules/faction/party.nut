// ::mods_hookExactClass("entity/world/party", function(o) {
//     o.onCombatWon = function()
// 	{
//         if (!this.m.Flags.has("HomeID")) return;
//         local settlements = this.World.FactionManager.getFactionOfType(this.getFaction()).getSettlements();
//         for (s in settlements)
//         {
//             if (s.m.Flags.get("ID") == this.m.Flags.get("HomeID"))
//             {
//                 s.m.Flags.set("Power", s.m.Flags.get("Power") + 20);
//                 break;
//             }
//         }
// 	}
// });