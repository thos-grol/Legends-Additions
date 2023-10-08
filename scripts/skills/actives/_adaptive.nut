this._adaptive <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives._adaptive";
		this.m.Name = "Adaptive";
		this.m.Description = "Learn a new weapon tree"
		this.m.Icon = "skills/adaptive.png";
		this.m.IconDisabled = "skills/adaptive_bw.png";
		this.m.ReturnFavorSounds <- [
			"sounds/combat/return_favor_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();
		
		return tooltip;
	}

	function isUsable()
	{
		return true;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		return actor.isPlacedOnMap();
	}

	function onUse( _user, _targetTile )
	{
		local possibleTrees = this.getPossibleTrees();
		this.chooseAndAddTree(possibleTrees);
		return true;
	}

	function getUnactivatedPerkTooltipHints()
	{
		local possibleTrees = this.getPossibleTrees();
		local descText = "";
		local possibleTreesText = "";

		if (typeof possibleTrees != "array" || possibleTrees.len() <= 1)
		{
			local name = typeof possibleTrees != "array" ? possibleTrees.Name : possibleTrees[0].Name;
			descText = "Activating this Perk will grant the following Perk Group:\n";
			possibleTreesText = "[color=#0b0084]" + name + "[/color]";
		}
		else
		{
			descText = "Activating this Perk will randomly grant one of the following Perk Groups:\n";
			possibleTreesText = "[color=#0b0084]";

			for( local i = 0; i < possibleTrees.len() - 2; i++ )
			{
				possibleTreesText = possibleTreesText + (possibleTrees[i].Name + ", ");
			}

			possibleTreesText = possibleTreesText + (possibleTrees[possibleTrees.len() - 2].Name + ", or ");
			possibleTreesText = possibleTreesText + (possibleTrees[possibleTrees.len() - 1].Name + "[/color]");
		}

		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/tooltips/positive.png",
				text = descText + possibleTreesText
			}
		];
		return ret;
	}

	function getPossibleTrees()
	{
		local item;
		local itemtype;
		local newTree;
		local actor = this.getContainer().getActor();

		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
		{
			item = actor.getMainhandItem();

			if (item.isItemType(this.Const.Items.ItemType.Weapon))
			{
				newTree = this.getWeaponPerkTree(item);
			}

			newTree = this.getOnlyNonExistingTrees(newTree);

			if (newTree != null && newTree.len() > 0)
			{
				return newTree;
			}
		}

		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
		{
			item = actor.getOffhandItem();

			if (item.isItemType(this.Const.Items.ItemType.Shield))
			{
				newTree = this.getShieldPerkTree(item);
			}
			else
			{
				newTree = this.getMiscPerkTree(item);
			}

			newTree = this.getOnlyNonExistingTrees(newTree);

			if (newTree != null && newTree.len() > 0)
			{
				return newTree;
			}
		}

		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) == null && actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			newTree = this.getOnlyNonExistingTrees(this.Const.Perks.FistsClassTree);

			if (newTree != null && newTree.len() > 0)
			{
				return newTree;
			}
		}

		if (newTree == null || newTree.len() < 1)
		{
			newTree = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.TrainedTree
			];
		}

		newTree = this.getOnlyNonExistingTrees(newTree);

		if (newTree == null || newTree.len() < 1)
		{
			newTree = this.Const.Perks.PhilosophyMagicTree.Tree;
		}

		return newTree;
	}

	function getOnlyNonExistingTrees( _newTree )
	{
		if (_newTree == null || typeof _newTree == "array" && _newTree.len() < 1)
		{
			return [];
		}

		local actor = this.getContainer().getActor();

		if (typeof _newTree != "array")
		{
			return actor.getBackground().hasPerkGroup(_newTree) ? null : _newTree;
		}

		local ret = [];

		foreach( tree in _newTree )
		{
			if (!actor.getBackground().hasPerkGroup(tree))
			{
				ret.append(tree);
			}
		}

		return ret;
	}

	function chooseAndAddTree( _newTree )
	{
		local actor = this.getContainer().getActor();

		if (typeof _newTree != "array")
		{
			actor.getBackground().addPerkGroup(_newTree.Tree);
		}
		else if (_newTree.len() > 0)
		{
			local randomIndex = this.Math.rand(0, _newTree.len() - 1);
			local randomTree = _newTree[randomIndex];
			actor.getBackground().addPerkGroup(randomTree.Tree);
		}
		else
		{
			this.logWarning("Adaptive Perk had no Tree to add");
		}
	}

	function getShieldPerkTree( _item )
	{
		return this.Const.Perks.ShieldTree;
	}

	function getMiscPerkTree( _item )
	{
		switch(_item.getID())
		{
		case "weapon.holy_water":
			return this.Const.Perks.FaithClassTree;

		case "weapon.daze_bomb":
			return this.Const.Perks.JugglerClassTree;

		case "weapon.fire_bomb":
			return this.Const.Perks.RepairClassTree;

		case "weapon.acid_flask":
			return this.Const.Perks.HealerClassTree;
		}

		return null;
	}

	function getWeaponPerkTree( _item )
	{
		switch(true)
		{
		case _item.getID() == "weapon.legend_shovel" || _item.getID() == "weapon.legend_named_shovel":
			return this.Const.Perks.ShovelClassTree;

		case _item.getID() == "weapon.sickle" || _item.getID() == "weapon.goblin_notched_blade" || _item.getID() == "weapon.legend_named_sickle":
			return this.Const.Perks.SickleClassTree;

		case _item.getID() == "weapon.woodcutters_axe" || _item.getID() == "weapon.legend_saw":
			return this.Const.Perks.WoodaxeClassTree;

		case _item.getID() == "weapon.legend_hammer" || _item.getID() == "weapon.legend_named_blacksmith_hammer":
			return this.Const.Perks.HammerClassTree;

		case _item.getID() == "weapon.pickaxe":
			return this.Const.Perks.PickaxeClassTree;

		case _item.getID() == "weapon.butchers_cleaver" || _item.getID() == "weapon.legend_named_butchers_cleaver":
			return this.Const.Perks.ButcherClassTree;

		case _item.getID() == "weapon.legend_cat_o_nine_tails":
			return this.Const.Perks.NinetailsClassTree;

		case _item.getID() == "weapon.knife" || _item.getID() == "weapon.legend_shiv":
			return this.Const.Perks.KnifeClassTree;

		case _item.getID() == "weapon.legend_grisly_scythe" || _item.getID() == "weapon.legend_scythe" || _item.getID() == "weapon.warscythe" || _item.getID() == "weapon.named_warscythe":
			return this.Const.Perks.ScytheClassTree;

		case _item.isItemType(this.Const.Items.ItemType.Pitchfork):
			return this.Const.Perks.PitchforkClassTree;

		case _item.isWeaponType(this.Const.Items.WeaponType.Musical):
			return this.Const.Perks.BardClassTree;

		case _item.isItemType(this.Const.Items.ItemType.Shortbow):
			return this.Const.Perks.ShortbowClassTree;

		case _item.isItemType(this.Const.Items.ItemType.Net):
			return this.Const.Perks.BeastClassTree;

		case _item.getID() == "weapon.militia_spear" || _item.getID() == "weapon.legend_wooden_spear" || _item.getID() == "weapon.ancient_spear":
			return this.Const.Perks.MilitiaClassTree;

		case _item.isWeaponType(this.Const.Items.WeaponType.Sword) && _item.isItemType(this.Const.Items.ItemType.TwoHanded):
			return this.Const.Perks.GreatSwordTree;
		}

		local ret = [];
		local weaponToPerkMap = {
			Axe = this.Const.Perks.AxeTree,
			Bow = this.Const.Perks.BowTree,
			Cleaver = this.Const.Perks.CleaverTree,
			Crossbow = this.Const.Perks.CrossbowTree,
			Dagger = this.Const.Perks.DaggerTree,
			Firearm = this.Const.Perks.CrossbowTree,
			Flail = this.Const.Perks.FlailTree,
			Hammer = this.Const.Perks.HammerTree,
			Mace = this.Const.Perks.MaceTree,
			Polearm = this.Const.Perks.PolearmTree,
			Sling = this.Const.Perks.SlingTree,
			Spear = this.Const.Perks.SpearTree,
			Sword = this.Const.Perks.SwordTree,
			Staff = this.Const.Perks.StaffTree,
			Throwing = this.Const.Perks.ThrowingTree
		};

		foreach( weapon, tree in weaponToPerkMap )
		{
			if (_item.isWeaponType(this.Const.Items.WeaponType[weapon]))
			{
				ret.push(tree);
			}
		}

		return ret;
		return null;
	}
});
