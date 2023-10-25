this.abstract_human <- this.inherit("scripts/entity/tactical/human", {
	m = {
		is_build = false,
		TREE_DEFENSE = null,
		TREE_TRAIT1 = null,
		TREE_TRAIT2 = null,
		TREE_WEAPON = null,
		PATTERN_OVERWRITE = null
	},
	function onInit()
	{
		this.human.onInit();
	}

	function create()
	{
		this.human.create();
		this.m.XP = ::B.Info[this.m.Type].Level * 35;
	}

	function pickOutfit()
	{
		foreach( item in this.Const.World.Common.pickOutfit(::B.Info[this.m.Type].Outfit) )
		{
			this.m.Items.equip(item);
		}
	}

	function pickOffhand()
	{
	}

	function pickWeapon()
	{
		local loadout = ::MSU.Array.rand(::B.Info[this.m.Type].Loadout);
		foreach(item in loadout)
		{
			this.m.Items.equip(::new(item));
		}
	}

	function assignRandomEquipment()
	{
		//Assign outfit and get the defense tree
		pickOutfit();
		local weight_armor = this.getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;
		if (weight_armor <= 20) this.m.TREE_DEFENSE = ::Const.Perks.LightArmorTree.Tree;
        else if (weight_armor <= 40) this.m.TREE_DEFENSE = ::Const.Perks.MediumArmorTree.Tree;
        else this.m.TREE_DEFENSE = ::Const.Perks.HeavyArmorTree.Tree;

		if ("Builds" in ::B.Info[this.m.Type])
		{
			return;
		}

		//TREE_TRAITS
		local roll = [
			::Const.Perks.AgileTree.Tree,
			::Const.Perks.IndestructibleTree.Tree,
			::Const.Perks.ViciousTree.Tree,
			::Const.Perks.DeviousTree.Tree,
			::Const.Perks.CalmTree.Tree,
			::Const.Perks.FastTree.Tree,
			::Const.Perks.LargeTree.Tree,
			::Const.Perks.SturdyTree.Tree,
			::Const.Perks.FitTree.Tree
		]

		this.m.TREE_TRAIT1 = ::MSU.Array.rand(roll);
		::MSU.Array.removeByValue(roll, this.m.TREE_TRAIT1);
		this.m.TREE_TRAIT2 = ::MSU.Array.rand(roll);

		//TREE_WEAPON
		pickWeapon();
		local weapon = this.getMainhandItem();
		::logInfo(weapon.m.ID);
		this.m.TREE_WEAPON = ::Z.Perks.getWeaponPerkTree(weapon)[0].Tree;
		if (!weapon.isItemType(::Const.Items.ItemType.TwoHanded)) pickOffhand();

		try {
			if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
				this.m.Items.equip(this.new("scripts/items/ammo/powder_bag"));
		} catch (exception){}

		//Add perks according to specified pattern
		local i = 1;
		foreach( pattern in ::B.Info[this.m.Type].Pattern )
		{
			if (this.m.PATTERN_OVERWRITE != null && i in this.m.PATTERN_OVERWRITE)
				decode_add(this.m.PATTERN_OVERWRITE[i]);
			else decode_add(pattern);
			i++;
		}

		//add level ups
		foreach( stat in ::B.Info[this.m.Type].LevelUps )
		{
			switch(stat[0])
			{
				case "Health":
				::B.Lib.level_health(this, stat[1], stat[2])
				break;

				case "Fatigue":
				::B.Lib.level_fatigue(this, stat[1], stat[2])
				break;

				case "Resolve":
				::B.Lib.level_resolve(this, stat[1], stat[2])
				break;

				case "Initiative":
				::B.Lib.level_initiative(this, stat[1], stat[2])
				break;

				case "Melee Skill":
				::B.Lib.level_melee_skill(this, stat[1], stat[2])
				break;

				case "Ranged Skill":
				::B.Lib.level_ranged_skill(this, stat[1], stat[2])
				break;

				case "Melee Defense":
				::B.Lib.level_melee_defense(this, stat[1], stat[2])
				break;

				case "Ranged Defense":
				::B.Lib.level_ranged_defense(this, stat[1], stat[2])
				break;
			}
		}
	}

	function decode_add(_array)
	{
		local perk = null;
		switch(_array[0])
		{
			case "Z":
			this.getSkills().add(::new(_array[1]));
			return; //return bc no need to find perk

			case "T":
			perk = ::Math.rand(1,100) <= 50 ? this.m.TREE_TRAIT1[_array[1] - 1][0] : this.m.TREE_TRAIT2[_array[1] - 1][0];
			break;

			case "D":
			perk = this.m.TREE_DEFENSE[_array[1] - 1][0];
			break;

			case "W":
			perk = this.m.TREE_WEAPON[_array[1] - 1][0];
			break;
		}

		this.getSkills().add(::new(::Const.Perks.PerkDefObjects[perk].Script));
	}

});

