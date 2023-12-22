this.hedge_knight <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.HedgeKnight;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.HedgeKnight.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.HedgeKnight);
		b.TargetAttractionMult = 1.0;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
	}

	function pickOutfit()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local armor = [
				[
					1,
					"coat_of_plates"
				],
				[
					1,
					"coat_of_scales"
				],
				[
					1,
					"heavy_lamellar_armor"
				]
			];
			local helmet = [
				[
					30,
					"full_helm"
				],
				[
					10,
					"closed_flat_top_with_mail"
				],
				[
					5,
					"legend_helm_breathed"
				],
				[
					5,
					"legend_helm_full"
				],
				[
					5,
					"legend_helm_bearded"
				],
				[
					5,
					"legend_helm_point"
				],
				[
					5,
					"legend_helm_snub"
				],
				[
					5,
					"legend_helm_short"
				],
				[
					5,
					"legend_helm_curved"
				],
				[
					2,
					"legend_enclave_vanilla_great_helm_01"
				],
				[
					2,
					"legend_enclave_vanilla_armet_01"
				],
				[
					2,
					"legend_enclave_vanilla_armet_02"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_01"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_02"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_03"
				],
				[
					2,
					"legend_enclave_vanilla_kettle_sallet_01"
				],
				[
					2,
					"legend_enclave_vanilla_kettle_sallet_02"
				]
			];
			local outfits = [
				[
					1,
					"brown_hedgeknight_outfit_00"
				]
			];

			foreach( item in ::Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item);
			}

			return;
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = [
				[
					1,
					"coat_of_plates"
				],
				[
					1,
					"coat_of_scales"
				],
				[
					1,
					"heavy_lamellar_armor"
				],
				[
					1,
					"brown_hedgeknight_armor"
				]
			];
			this.m.Items.equip(::Const.World.Common.pickArmor(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = [
				[
					30,
					"full_helm"
				],
				[
					10,
					"closed_flat_top_with_mail"
				],
				[
					5,
					"legend_helm_breathed"
				],
				[
					5,
					"legend_helm_full"
				],
				[
					5,
					"legend_helm_bearded"
				],
				[
					5,
					"legend_helm_point"
				],
				[
					5,
					"legend_helm_snub"
				],
				[
					5,
					"legend_helm_short"
				],
				[
					5,
					"legend_helm_curved"
				],
				[
					2,
					"legend_enclave_vanilla_great_helm_01"
				],
				[
					2,
					"legend_enclave_vanilla_armet_01"
				],
				[
					2,
					"legend_enclave_vanilla_armet_02"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_01"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_02"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_03"
				],
				[
					2,
					"legend_enclave_vanilla_kettle_sallet_01"
				],
				[
					2,
					"legend_enclave_vanilla_kettle_sallet_02"
				]
			];
			this.m.Items.equip(::Const.World.Common.pickHelmet(helmet));
		}
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = ::Math.rand(1, 2);
		if (r == 1) //armor
		{
			this.m.Items.equip(::Const.World.Common.pickArmor([
				[
					1,
					"named/brown_coat_of_plates_armor"
				],
				[
					1,
					"named/golden_scale_armor"
				],
				[
					1,
					"named/green_coat_of_plates_armor"
				]
			]));
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

