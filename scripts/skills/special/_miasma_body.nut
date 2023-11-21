this._miasma_body <- this.inherit("scripts/skills/skill", {
	m = {
		Damage = 5,
		Actor = null
	},

	function getDamage()
	{
		return this.m.Damage;
	}

	function setDamage( _d )
	{
		this.m.Damage = _d;
	}

	function setActor( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	function getAttacker()
	{
		if (::MSU.isNull(this.m.Actor)) return this.getContainer().getActor();
		if (this.m.Actor.getID() != this.getContainer().getActor().getID())
		{
			if (this.m.Actor.isAlive() && this.m.Actor.isPlacedOnMap()) return this.m.Actor;
		}
		return this.getContainer().getActor();
	}

	function create()
	{
		this.m.ID = "effects._miasma_body";
		this.m.Name = "Miasma Body";
		this.m.Icon = "ui/perks/research_miasma_body.png";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onNewRound()
	{
		local actor = this.getContainer().getActor();

		local bonus = 0;
		local attacker = getAttacker();
		if (attacker.getSkills().getSkillByID("perk.meditation.omen_of_decay") != null)
			bonus = attacker.getFlags().has("decay_bonus") ? attacker.getFlags().getAsInt("decay_bonus") : 0;

		local p = {
			Type = "miasma",
			Tooltip = "Miasma lingers here, harmful to any living being",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = true,
			IsAppliedOnEnter = true,
			Timeout = this.Time.getRound() + 3,
			IsByPlayer = actor.getFaction() == this.Const.Faction.PlayerAnimals,
			Actor = getAttacker(),
			Damage = this.m.Damage + bonus,
			Callback = ::Z.Lib.apply_miasma,
			function Applicable( _a )
			{
				return true;
			}

		};

		foreach (tile in ::Z.getNeighbors(actor.getTile()))
		{
			if (::Math.rand(1,100) > 50) continue;

			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "miasma") tile.Properties.Effect.Timeout = this.Time.getRound() + 2;
			else
			{
				tile.Properties.Effect = clone p;
				local particles = [];

				for( local i = 0; i < this.Const.Tactical.MiasmaParticles.len(); i = i )
				{
					particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.MiasmaParticles[i].Brushes, tile, this.Const.Tactical.MiasmaParticles[i].Delay, this.Const.Tactical.MiasmaParticles[i].Quantity, this.Const.Tactical.MiasmaParticles[i].LifeTimeQuantity, this.Const.Tactical.MiasmaParticles[i].SpawnRate, this.Const.Tactical.MiasmaParticles[i].Stages));
					i = ++i;
				}

				this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
			}
		}
	}



});

