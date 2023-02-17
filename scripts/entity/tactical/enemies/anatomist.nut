this.anatomist <- this.inherit("scripts/entity/tactical/enemies/bandit_raider", {
	m = {},
	function create()
	{
		this.bandit_raider.create();
	}

	function onInit()
	{
		this.bandit_raider.onInit();
		local roll = this.Math.rand(1.0, 100.0);
		local potions = [
			"direwolf",
			"ghoul",
			"spider",
			"unhold",
			"orc"
		]
		this.add_potion(::MSU.Array.rand(potions), false);
		if (roll <= 5.0 * this.getScaledDifficultyMult()) this.makeMiniboss();
	}

	function getScaledDifficultyMult()
	{
		local s = this.Math.maxf(0.5, 0.6 * this.Math.pow(0.01 * this.World.State.getPlayer().getStrength(), 0.9));
		local d = this.Math.minf(0, s + this.Math.minf(1.0, this.World.getTime().Days * 0.01));
		return d * ::Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{

		// if (this.Math.rand(1.0, 100.0) <= 5.0)
		// {
		// 	//FEATURE_5: Anatomist research notes + add to possible books
		// }
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

});