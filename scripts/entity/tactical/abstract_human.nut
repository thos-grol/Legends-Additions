this.abstract_human <- this.inherit("scripts/entity/tactical/human", {
	m = {
		TREE_DEFENSE = null,
		TREE_TRAIT1 = null,
		TREE_TRAIT2 = null,
		TREE_WEAPON = null,
		PATTERN_OVERWRITE = null,
		Build = null
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

	function pickNamed()
	{
		//decide what item will be named
		local r = this.Math.rand(1, 4);
		if (r == 1) //helmet
		{
			local named = this.Const.Items.NamedHelmets;
			local weightName = this.Const.World.Common.convNameToList(named);
			this.m.Items.equip(this.Const.World.Common.pickHelmet(weightName));
		}
		else if (r == 2) //armor
		{
			local named = this.Const.Items.NamedArmors;
			local weightName = this.Const.World.Common.convNameToList(named);
			this.m.Items.equip(this.Const.World.Common.pickArmor(weightName));
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function assignRandomEquipment()
	{
		if (this.m.IsMiniboss) pickNamed(); //if is champion

		//Assign outfit and get the defense tree
		pickOutfit();
		local weight_armor = this.getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;
		if (weight_armor <= 20) this.m.TREE_DEFENSE = ::Const.Perks.LightArmorTree.Tree;
        else if (weight_armor <= 40) this.m.TREE_DEFENSE = ::Const.Perks.MediumArmorTree.Tree;
        else this.m.TREE_DEFENSE = ::Const.Perks.HeavyArmorTree.Tree;

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

		if ("Builds" in ::B.Info[this.m.Type]
			&& "BuildsChance" in ::B.Info[this.m.Type]
			&& ::Math.rand(1,100) <= ::B.Info[this.m.Type].BuildsChance)
		{

			this.m.Build = ::MSU.Table.randValue(::B.Info[this.m.Type].Builds);

			::MSU.Log.printData( this.m.Build, 2);

			//build add weapon
			local loadout = ("IsMinibossWeapon" in this.m && this.m.IsMinibossWeapon) ? ::MSU.Array.rand(this.m.Build.NamedLoadout) : ::MSU.Array.rand(this.m.Build.Loadout);
			foreach(item in loadout)
			{
				this.m.Items.equip(::new(item));
			}

			local weapon = this.getMainhandItem();
			if (weapon != null && "m" in weapon)
			{
				this.m.TREE_WEAPON = ::Z.Perks.getWeaponPerkTree(weapon)[0].Tree;
			}
			

			try {
				if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				else if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				else if (weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
					this.m.Items.equip(this.new("scripts/items/ammo/powder_bag"));
			} catch (exception){}

			//build add perks
			foreach( pattern in this.m.Build.Pattern)
			{
				decode_add(pattern);
			}

			//build add levelups
			pickLevelups(this.m.Build.LevelUps);
			post_init();
			return;
		}

		local loadout = ("IsMinibossWeapon" in this.m && this.m.IsMinibossWeapon) ? ::MSU.Array.rand(::B.Info[this.m.Type].NamedLoadout) : ::MSU.Array.rand(::B.Info[this.m.Type].Loadout);
		foreach(item in loadout)
		{
			this.m.Items.equip(::new(item));
		}

		//TREE_WEAPON
		local weapon = this.getMainhandItem();
		::logInfo(weapon.m.ID);
		this.m.TREE_WEAPON = ::Z.Perks.getWeaponPerkTree(weapon)[0].Tree;

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
		pickLevelups(::B.Info[this.m.Type].LevelUps);
		post_init();

	}

	function post_init()
	{
	}

	function decode_add(_array)
	{
		local perk = null;

		if (_array.len() == 1)
		{
			this.getSkills().add(::new(_array[0]));
			return;
		}

		switch(_array[0])
		{
			case "T":
				local b = ::Math.rand(1,100) <= 50;
				perk = b ? this.m.TREE_TRAIT1[_array[1] - 1][0] : this.m.TREE_TRAIT2[_array[1] - 1][0];

				if (this.getSkills().hasSkill(::Const.Perks.PerkDefObjects[perk].ID))
				{
					b = !b;
					perk = b ? this.m.TREE_TRAIT1[_array[1] - 1][0] : this.m.TREE_TRAIT2[_array[1] - 1][0];
				}

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

	function pickLevelups(_source)
	{
		foreach( stat in _source)
		{
			switch(stat[0])
			{
				case "Health":
				::B.Lib.level_health(this, stat[1], stat[2], stat[3]);
				break;

				case "Fatigue":
				::B.Lib.level_fatigue(this, stat[1], stat[2], stat[3]);
				break;

				case "Resolve":
				::B.Lib.level_resolve(this, stat[1], stat[2], stat[3]);
				break;

				case "Initiative":
				::B.Lib.level_initiative(this, stat[1], stat[2], stat[3]);
				break;

				case "Melee Skill":
				::B.Lib.level_melee_skill(this, stat[1], stat[2], stat[3]);
				break;

				case "Ranged Skill":
				::B.Lib.level_ranged_skill(this, stat[1], stat[2], stat[3]);
				break;

				case "Melee Defense":
				::B.Lib.level_melee_defense(this, stat[1], stat[2], stat[3]);
				break;

				case "Ranged Defense":
				::B.Lib.level_ranged_defense(this, stat[1], stat[2], stat[3]);
				break;
			}
		}
	}

});

