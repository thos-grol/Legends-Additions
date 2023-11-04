this.goblin <- this.inherit("scripts/entity/tactical/actor", {
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
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinAmbusher);
		b.IsFleetfooted = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_goblin_01_body";
		this.addSprite("socket").setBrush("bust_base_goblins");
		local quiver = this.addSprite("quiver");
		quiver.Visible = false;
		local body = this.addSprite("body");
		body.setBrush("bust_goblin_01_body");
		body.varySaturation(0.1);
		body.varyColor(0.07, 0.07, 0.09);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_goblin_01_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_goblin_01_head_injured");
		this.addSprite("helmet");
		this.addSprite("helmet_damage");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;

		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));
		this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
	}

	function create()
	{
		this.m.XP = ::B.Info[this.m.Type].Level * 35;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.BloodSplatterOffset = this.createVec(-10, 15);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/goblin_death_00.wav",
			"sounds/enemies/goblin_death_01.wav",
			"sounds/enemies/goblin_death_02.wav",
			"sounds/enemies/goblin_death_03.wav",
			"sounds/enemies/goblin_death_04.wav",
			"sounds/enemies/goblin_death_05.wav",
			"sounds/enemies/goblin_death_06.wav",
			"sounds/enemies/goblin_death_07.wav",
			"sounds/enemies/goblin_death_08.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/goblin_flee_00.wav",
			"sounds/enemies/goblin_flee_01.wav",
			"sounds/enemies/goblin_flee_02.wav",
			"sounds/enemies/goblin_flee_03.wav",
			"sounds/enemies/goblin_flee_04.wav",
			"sounds/enemies/goblin_flee_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/goblin_hurt_00.wav",
			"sounds/enemies/goblin_hurt_01.wav",
			"sounds/enemies/goblin_hurt_02.wav",
			"sounds/enemies/goblin_hurt_03.wav",
			"sounds/enemies/goblin_hurt_04.wav",
			"sounds/enemies/goblin_hurt_05.wav",
			"sounds/enemies/goblin_hurt_06.wav",
			"sounds/enemies/goblin_hurt_07.wav",
			"sounds/enemies/goblin_hurt_08.wav",
			"sounds/enemies/goblin_hurt_09.wav",
			"sounds/enemies/goblin_hurt_10.wav",
			"sounds/enemies/goblin_hurt_11.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/goblin_idle_00.wav",
			"sounds/enemies/goblin_idle_01.wav",
			"sounds/enemies/goblin_idle_02.wav",
			"sounds/enemies/goblin_idle_03.wav",
			"sounds/enemies/goblin_idle_04.wav",
			"sounds/enemies/goblin_idle_05.wav",
			"sounds/enemies/goblin_idle_06.wav",
			"sounds/enemies/goblin_idle_07.wav",
			"sounds/enemies/goblin_idle_08.wav",
			"sounds/enemies/goblin_idle_09.wav",
			"sounds/enemies/goblin_idle_10.wav",
			"sounds/enemies/goblin_idle_11.wav",
			"sounds/enemies/goblin_idle_12.wav",
			"sounds/enemies/goblin_idle_13.wav",
			"sounds/enemies/goblin_idle_14.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 0.9;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Flee] = 1.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 0.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 1.25;
		this.m.SoundPitch = this.Math.rand(95, 110) * 0.01;
		this.m.Flags.add("goblin");
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = this.Math.rand(1, 100) < 50;

		if (_tile != null)
		{
			this.m.IsCorpseFlipped = flip;
			local decal;
			local skin = this.getSprite("body");
			decal = _tile.spawnDetail("bust_goblin_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.setBrightness(0.9);
			decal.Scale = 0.95;
			_tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip);

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				if (!this.getItems().getAppearance().HideCorpseHead)
				{
					decal = _tile.spawnDetail(this.getSprite("head").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = skin.Color;
					decal.Saturation = skin.Saturation;
					decal.setBrightness(0.9);
					decal.Scale = 0.95;
				}

				if (this.getItems().getAppearance().HelmetCorpse != "")
				{
					decal = _tile.spawnDetail(this.getItems().getAppearance().HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.setBrightness(0.9);
					decal.Scale = 0.95;
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					this.getSprite("head").getBrush().Name + "_dead",
					this.getItems().getAppearance().HelmetCorpse
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, 30), 180.0, this.getSprite("head").getBrush().Name + "_dead_bloodpool");
				decap[0].Color = skin.Color;
				decap[0].Saturation = skin.Saturation;
				decap[0].setBrightness(0.9);
				decap[0].Scale = 0.95;

				if (decap.len() >= 2)
				{
					decap[1].setBrightness(0.9);
				}
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				local decal = _tile.spawnDetail("bust_goblin_body_dead_guts", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "A " + this.getName();
			corpse.Tile = _tile;
			corpse.IsResurrectable = false;
			corpse.IsConsumable = true;
			corpse.Items = this.getItems();
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.getItems().dropAll(_tile, _killer, flip);
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		_appearance.Quiver = "bust_goblin_quiver";
		this.actor.onAppearanceChanged(_appearance, _setDirty);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
	}

	function onAfterInit()
	{
		this.getSprite("status_rooted").Scale = 0.47;
		this.setSpriteOffset("status_rooted", this.createVec(0, -5));
		this.actor.onAfterInit();
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

			//build add perks
			foreach( pattern in this.m.Build.Pattern)
			{
				decode_add(pattern);
			}

			//build add levelups
			pickLevelups(this.m.Build.LevelUps);
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

