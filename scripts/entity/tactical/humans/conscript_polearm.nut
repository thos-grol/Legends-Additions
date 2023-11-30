this.conscript_polearm <- this.inherit("scripts/entity/tactical/humans/conscript", {
	m = {},
	function create()
	{
		this.conscript.create();
		this.m.Type = this.Const.EntityType.ConscriptPolearm;
	}

	function onInit()
	{
		this.conscript.onInit();
	}

	function pickOutfit()
	{
		local r;
		local banner = 3;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = 13;
		}

		local variant;

		if (banner == 12)
		{
			variant = 9;
		}
		else if (banner == 13)
		{
			variant = 10;
		}
		else
		{
			variant = 8;
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"oriental/linothorax",
				variant
			],
			[
				1,
				"oriental/southern_mail_shirt"
			]
		]));
		local variant = 7;

		if (banner == 12)
		{
			variant = 12;
		}
		else if (banner == 13)
		{
			variant = 8;
		}
		else if (banner == 14)
		{
			variant = 7;
		}

		local helm = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/southern_head_wrap",
				variant
			]
		]);
		this.m.Items.equip(helm);
	}

});

