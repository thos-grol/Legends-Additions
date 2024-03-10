//cursed item rolls UUID from uint16
//adds lifebound_trait with uuid
//oncombatstat -> check items -> if lifebound trait is missing, kill bro
this.lifebound_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		UUID = 0,
	},
	function create()
	{
		this.m.ID = "trait.lifebound_trait";
		this.m.Name = "Lifebound";
		this.m.Icon = "ui/traits/IntensiveTraining.png";
		this.m.Description = "This character can increase their abilities if you upgrade your camp training facilities.";
		this.m.Order = ::Const.SkillOrder.Background + 1;
		this.m.Type = ::Const.SkillType.Trait;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsHidden = false;
		this.m.IsSerialized = true;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		local items = actor.getItems().getAllItems();
		foreach(i in items)
		{
			if (!("UUID" in i.m)) continue;
			if (i.m.UUID != this.m.UUID) continue;
			return;
		}

		actor.kill();
		::Tactical.EventLog.log(
			::Const.UI.getColorizedEntityName(_user) + ::MSU.Text.colorRed(" has died from a curse")
		);
	}

	function setUUID(_UUID)
	{
		this.m.UUID = _UUID;
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU16(this.m.UUID);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.UUID = _in.readU16();
	}

});

