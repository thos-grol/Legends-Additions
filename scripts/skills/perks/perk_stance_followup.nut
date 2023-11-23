::Const.Strings.PerkName.StanceFollowup <- "Follow Up";
::Const.Strings.PerkDescription.StanceFollowup <- ::MSU.Text.color(::Z.Color.Purple, "Stance")

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Turn End")
+ "\n Follow up for free";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceFollowup].Name = ::Const.Strings.PerkName.StanceFollowup;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceFollowup].Tooltip = ::Const.Strings.PerkDescription.StanceFollowup;

this.perk_stance_followup <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.stance.followup";
		this.m.Name = ::Const.Strings.PerkName.StanceFollowup;
		this.m.Description = ::Const.Strings.PerkDescription.StanceFollowup;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Stance", true);
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();
		local skill = this.m.Container.getSkillByID("actives.follow_up");
		if (skill == null || !skill.isUsable()) return;
		skill.useForFree(actor.getTile());
	}
});