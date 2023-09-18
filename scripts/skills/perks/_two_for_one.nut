this.perk_ptr_two_for_one <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ptr_two_for_one";
		this.m.Name = this.Const.Strings.PerkName.PTRTwoForOne;
		this.m.Description = this.Const.Strings.PerkDescription.PTRTwoForOne;
		this.m.Icon = "ui/perks/ptr_two_for_one.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate(_properties)
	{
		local skills = [];

		skills.push(this.getContainer().getSkillByID("actives.thrust"));
		skills.push(this.getContainer().getSkillByID("actives.legend_glaive_slash"));
		skills.push(this.getContainer().getSkillByID("actives.prong"));

		foreach (s in skills)
		{
			if (s != null && s.m.ActionPointCost > 0)
			{
				s.m.ActionPointCost -= 1;
			}
		}
	}
});
