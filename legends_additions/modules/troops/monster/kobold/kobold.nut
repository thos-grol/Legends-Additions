::mods_hookExactClass("entity/tactical/kobold", function(o) {

	o.onInit = function()
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
		this.m.Items.getAppearance().Body = "bust_kobold_01";
		this.addSprite("socket").setBrush("bust_base_goblins");
		local quiver = this.addSprite("quiver");
		quiver.Visible = false;
		local variant = this.Math.rand(1, 5);
		local body = this.addSprite("body");
		body.setBrush("bust_kobold_0" + variant);
		body.varySaturation(0.3);
		body.varyColor(0.1, 0.1, 0.1);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_kobold_0" + variant + "_damaged");
		local head = this.addSprite("head");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_goblin_01_head_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.m.Skills.add(this.new("scripts/skills/racial/kobold_racial"));
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_boondock_blade"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_tumble"));

		if (this.Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}
	}

});

