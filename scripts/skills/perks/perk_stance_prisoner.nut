::Const.Strings.PerkName.StancePrisoner <- "Prisoner";
::Const.Strings.PerkDescription.StancePrisoner <- ::MSU.Text.color(::Z.Log.Color.Purple, "Stance")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "On incoming attack missed")
+ "\n Disarm the enemy rolling on their miss chance / 2";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StancePrisoner].Name = ::Const.Strings.PerkName.StancePrisoner;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StancePrisoner].Tooltip = ::Const.Strings.PerkDescription.StancePrisoner;

this.perk_stance_prisoner <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.stance.prisoner";
		this.m.Name = ::Const.Strings.PerkName.StancePrisoner;
		this.m.Description = ::Const.Strings.PerkDescription.StancePrisoner;
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

	function onMissed( _attacker, _skill )
	{
		local actor = this.getContainer().getActor();

		if (_skill != null && _skill.isAttack() && _skill.m.IsWeaponSkill && _attacker != null && _attacker.getID() != actor.getID())
		{
			if (!actor.isAlive() || _attacker.getMainhandItem() == null) return;
			if (actor.getTile().getDistanceTo(_attacker.getTile()) > 2) return;

			local miss_chance = ::Math.floor((100 - ::Math.min(::Math.max(_attacker.getCurrentProperties().MeleeSkill - actor.getCurrentProperties().MeleeDefense, 5), 95)) / 2);

			local roll = ::Math.rand(1, 100);
			if (roll > miss_chance) return;
			if (this.m.Container.hasSkill("effects.disarmed")) return;

			local effect = ::new("scripts/skills/effects/disarmed_effect");
			effect.m.TurnsLeft = 2;
			_attacker.getSkills().add(effect);
			this.Sound.play("sounds/general/prisoner.wav", 200.0, actor.getPos());

			if (!this.getContainer().getActor().isHiddenToPlayer() && _attacker.getTile().IsVisibleForPlayer)
			{
				::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_attacker) + " has been disarmed for 2 turns" + ::Z.Log.display_chance(roll, miss_chance));
			}
		}
	}
	
});