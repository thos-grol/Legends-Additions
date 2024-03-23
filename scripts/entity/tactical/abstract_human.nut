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
		foreach( item in ::Const.World.Common.pickOutfit(::B.Info[this.m.Type].Outfit) )
		{
			this.m.Items.equip(item);
		}
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = ::Math.rand(1, 4);
		if (r == 1) //helmet
		{
			local named = ::Const.Items.NamedHelmets;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickHelmet(weightName));
		}
		else if (r == 2) //armor
		{
			local named = ::Const.Items.NamedArmors;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickArmor(weightName));
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function assignRandomEquipment()
	{
		this.getFlags().set("Level", ::B.Info[this.m.Type].Level);
		
		if (this.m.IsMiniboss) pickNamed(); //if is champion
		//Assign outfit and get the defense tree
		pickOutfit();
		if (::Math.rand(1,100) <= 20) this.getSkills().add(::new("scripts/skills/traits/lucky_trait"));
		local weight_armor = this.getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;
		if (weight_armor <= 20) this.m.TREE_DEFENSE = ::Const.Perks.LightArmorTree.Tree;
        else if (weight_armor <= 40) this.m.TREE_DEFENSE = ::Const.Perks.MediumArmorTree.Tree;
        else this.m.TREE_DEFENSE = ::Const.Perks.HeavyArmorTree.Tree;

		helper_add_traits();
		helper_add_trait_trees();

		if ("Builds" in ::B.Info[this.m.Type]
			&& "BuildsChance" in ::B.Info[this.m.Type]
			&& ::Math.rand(1,100) <= ::B.Info[this.m.Type].BuildsChance)
		{

			this.m.Build = ::MSU.Table.randValue(::B.Info[this.m.Type].Builds);

			::MSU.Log.printData( this.m.Build, 2);

			try
			{
				//build add weapon
				local loadout = ("IsMinibossWeapon" in this.m && this.m.IsMinibossWeapon) ? ::MSU.Array.rand(this.m.Build.NamedLoadout) : ::MSU.Array.rand(this.m.Build.Loadout);
				foreach(item in loadout)
				{
					this.m.Items.equip(::new(item));
				}
			} catch(exception){}

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

		try
		{
			local loadout = ("IsMinibossWeapon" in this.m && this.m.IsMinibossWeapon) ? ::MSU.Array.rand(::B.Info[this.m.Type].NamedLoadout) : ::MSU.Array.rand(::B.Info[this.m.Type].Loadout);
			foreach(item in loadout)
			{
				this.m.Items.equip(::new(item));
			}
		} catch(exception){}

		//TREE_WEAPON
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
				::B.Lib.level_strength(this, stat[1], stat[2], stat[3]);
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

	function helper_add_traits()
	{
		local count = 0;
		local rand_trait;
		local excluded = {};

		while(true)
		{
			if (count == 2) break;

			rand_trait = ::MSU.Table.randValue(::Const.CharacterTraits);
			if (rand_trait[0] in ::Z.Lib.AIBlacklistedTraits) continue;
			if (rand_trait[0] in excluded) continue;
			
			local instance = ::new(rand_trait[1]);
			foreach(trait in instance.m.Excluded)
			{
				excluded[trait] <- 0;
			}

			this.getSkills().add(instance);
			count++;
		}
	}

	function helper_add_trait_trees()
	{
		local _exclude = {};
		local tree = helper_get_trait_tree(_exclude);
		_exclude[tree.ID] <- 0;
		this.m.TREE_TRAIT1 = tree.Tree;

		tree = helper_get_trait_tree(_exclude);
		this.m.TREE_TRAIT2 = tree.Tree;
	}

	function helper_get_trait_tree(_exclude)
	{
		if (this.getFlags().has("Large") && !("LargeTree" in _exclude) ) return ::Const.Perks.LargeTree;
		if (this.getFlags().has("Vicious") && !("ViciousTree" in _exclude) ) return ::Const.Perks.ViciousTree;
		if (this.getFlags().has("Devious") && !("DeviousTree" in _exclude) ) return ::Const.Perks.DeviousTree;
		if (this.getFlags().has("Sturdy") && !("SturdyTree" in _exclude) ) return ::Const.Perks.SturdyTree;
		if (this.getFlags().has("Agile") && !("AgileTree" in _exclude) ) return ::Const.Perks.AgileTree;
		if (this.getFlags().has("Tenacious") && !("IndestructibleTree" in _exclude) ) return ::Const.Perks.IndestructibleTree;
		if (this.getFlags().has("Fit") && !("FitTree" in _exclude) ) return ::Const.Perks.FitTree;

		local roll = [
			::Const.Perks.AgileTree,
			::Const.Perks.IndestructibleTree,
			::Const.Perks.ViciousTree,
			::Const.Perks.DeviousTree,
			::Const.Perks.CalmTree,
			::Const.Perks.LargeTree,
			::Const.Perks.SturdyTree,
			::Const.Perks.FitTree
		]

		for(local i = roll.len() - 1; i >= 0; i--)
		{
			if (roll[i].ID in _exclude) roll.remove(i);
		}
		return ::MSU.Array.rand(roll);
	}

	

});

