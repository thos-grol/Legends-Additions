::Const.Strings.PerkName.StanceAsura <- "Asura";
::Const.Strings.PerkDescription.StanceAsura <- ::MSU.Text.color(::Z.Log.Color.Purple, "Stance")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Fully unarmed:")
+ "\n Hand to Hand: " + ::MSU.Text.colorGreen("+3") + " CQC strikes"
+ "\n Kick: " + ::MSU.Text.colorGreen("+1") + " kick";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceAsura].Name = ::Const.Strings.PerkName.StanceAsura;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceAsura].Tooltip = ::Const.Strings.PerkDescription.StanceAsura;

this.perk_stance_asura <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.stance.asura";
		this.m.Name = ::Const.Strings.PerkName.StanceAsura;
		this.m.Description = ::Const.Strings.PerkDescription.StanceAsura;
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

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		local items = this.getContainer().getActor().getItems();

		if (_targetEntity == null
			|| items.hasBlockedSlot(::Const.ItemSlot.Offhand)
			|| items.getItemAtSlot(::Const.ItemSlot.Mainhand) != null
			|| items.getItemAtSlot(::Const.ItemSlot.Offhand) != null) return;
		if (_forFree) return;
		if (_targetTile == null) return;

		if (_skill.m.ID == "actives.hand_to_hand")
		{
			local attack = this.getContainer().getSkillByID("actives.hand_to_hand");
			for( local i = 0; i < 3; i++)
			{
				local info = {
					User = this.getContainer().getActor(),
					Skill = attack,
					TargetTile = _targetTile
				};
				::Time.scheduleEvent(this.TimeUnit.Virtual, ::Math.floor(::Const.Combat.RiposteDelay * i / 2), this.onRiposte, info);
			}
		}
		else if (_skill.m.ID == "actives.legend_kick")
		{
			local attack = this.getContainer().getSkillByID("actives.legend_kick");
			local info = {
				User = this.getContainer().getActor(),
				Skill = attack,
				TargetTile = _targetTile
			};
			::Time.scheduleEvent(this.TimeUnit.Virtual, ::Math.floor(::Const.Combat.RiposteDelay / 2), this.onRiposte, info);
		}
	}

	function onRiposte( _info )
	{
		_info.Skill.useForFree(_info.TargetTile);
	}
});