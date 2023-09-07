
::mods_hookExactClass("states/main_menu_state", function (o)
{
    o.postInit <- function()
	{
		local PERKS = {};
        //TODO: Add footers to all perks in trees
        local GROUPS = [::Const.Perks.TraitsTrees, ::Const.Perks.DefenseTrees, ::Const.Perks.WeaponTrees, ::Const.Perks.ClassTrees];
		foreach(group in GROUPS)
		{
			foreach(tree in group.Tree)
			{
				foreach(row in tree.Tree)
				{
					foreach(perk in row)
					{
                        ::Const.Perks.PerkDefObjects[perk].Tooltip += "\n\n" + tree.Name;
					}
				}
			}
		}
	}

    local onInit = o.onInit;

    o.onInit = function()
	{
        onInit();
        postInit();
	}

});
