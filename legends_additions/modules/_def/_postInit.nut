::mods_hookExactClass("states/main_menu_state", function (o)
{
    o.postInit <- function()
	{
		local PERKS = {};

        local GROUPS = [::Const.Perks.TraitsTrees, ::Const.Perks.DefenseTrees, ::Const.Perks.WeaponTrees, ::Const.Perks.ClassTrees];
		foreach(group in GROUPS)
		{
			foreach(tree in group.Tree)
			{
				foreach(row in tree.Tree)
				{
					foreach(perk in row)
					{
						if (::Const.Perks.PerkDefObjects[perk].Name in PERKS)
							::Const.Perks.PerkDefObjects[perk].Tooltip += ::MSU.Text.color(::Z.Log.Color.Blue, ", " + tree.Name);
						else
						{
							::Const.Perks.PerkDefObjects[perk].Tooltip += ::MSU.Text.color(::Z.Log.Color.Blue, "\n\n" + tree.Name);
							PERKS[::Const.Perks.PerkDefObjects[perk].Name] <- null;
						}
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
