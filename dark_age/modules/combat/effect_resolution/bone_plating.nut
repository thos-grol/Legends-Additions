//Bone plating triggers after gluttony shield

::mods_hookExactClass("skills/effects/bone_plating_effect", function (o)
{

    o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		local actor = this.getcontainer.getActor();

        local gluttony_barrier = actor.getSkills().getSkillByID("perk.nachzerer_gluttony_barrier");
        if (gluttony_barrier != null && gluttony_barrier.m.Charges > 0) return;
		local the_strongest = actor.getSkills().getSkillByID("perk.stance.the_strongest");
        if (the_strongest != null && the_strongest.m.Active) return;

        if (_hitInfo.BodyPart == ::Const.BodyPart.Body && _hitInfo.DamageDirect < 1.0)
		{
			_properties.DamageReceivedTotalMult = 0.0;
			this.Tactical.EventLog.logEx("Damage absorbed by Bone Plating");
			this.playSound();
			this.spawnIcon(this.m.Overlay, this.getContainer().getActor().getTile());
			this.removeSelf();
		}
	}

});