::mods_hookExactClass("entity/tactical/enemies/legend_hexe_leader", function(o)
{
    o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled()) this.updateAchievement("BagAHag", 1, 1);

		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			local hair = this.getSprite("hair");
			body.Alpha = 255;
			head.Alpha = 255;
			hair.Alpha = 255;
			decal = _tile.spawnDetail(body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;
				decal = _tile.spawnDetail(hair.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead",
					hair.getBrush().Name + "_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 45.0, head.getBrush().Name + "_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;
				decap[1].Scale = 0.95;
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(body.getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(body.getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "A Hexe";
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = i )
				{
					local r = this.Math.rand(1, 100);
					local loot = this.new("scripts/items/misc/legend_witch_leader_hair_item");
					loot.drop(_tile);
					i = ++i;
				}

				// local chance = 10;

				// if (this.LegendsMod.Configs().LegendMagicEnabled())
				// {
				// 	chance = 100;
				// }

				// if (this.Math.rand(1, 100) <= chance)
				// {
				// 	if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
				// 	{
				// 		local rune;
				// 		local selected = this.Math.rand(11, 13);

				// 		switch(selected)
				// 		{
				// 		case 11:
				// 			rune = this.new("scripts/items/legend_helmets/runes/legend_rune_clarity");
				// 			break;

				// 		case 12:
				// 			rune = this.new("scripts/items/legend_helmets/runes/legend_rune_bravery");
				// 			break;

				// 		case 13:
				// 			rune = this.new("scripts/items/legend_helmets/runes/legend_rune_luck");
				// 			break;
				// 		}

				// 		rune.setRuneVariant(selected);
				// 		rune.setRuneBonus(true);
				// 		rune.drop(_tile);
				// 	}
				// 	else
				// 	{
				// 		local token = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
				// 		token.setRuneVariant(this.Math.rand(11, 13));
				// 		token.setRuneBonus(true);
				// 		token.updateRuneSigilToken();
				// 		token.drop(_tile);
				// 	}
				// }
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}
    
});