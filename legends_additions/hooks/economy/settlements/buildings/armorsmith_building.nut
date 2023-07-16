::mods_hookExactClass("entity/world/settlements/buildings/armorsmith_building", function(o) {
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 20,
				P = 1.0,
				S = "armor/padded_leather"
			},
			{
				R = 20,
				P = 1.0,
				S = "legend_armor/chain/legend_armor_mail_shirt"
			},
			{
				R = 30,
				P = 1.0,
				S = "legend_armor/chain/legend_armor_mail_shirt"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/closed_mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "legend_helmets/helm/legend_helmet_norman_helm"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/buckler_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 50,
				P = 1.0,
				S = "shields/heater_shield"
			},
			{
				R = 75,
				P = 1.0,
				S = "shields/legend_tower_shield"
			},
			{
				R = 45,
				P = 1.0,
				S = "shields/kite_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "armor/leather_lamellar"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/mail_hauberk"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/lamellar_harness"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 80,
				P = 1.0,
				S = "tents/tent_scrap"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/leather_lamellar"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/mail_hauberk"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/lamellar_harness"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 70,
				P = 1.0,
				S = "armor/scale_armor"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/heavy_lamellar_armor"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/bascinet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/kettle_hat_with_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/kettle_hat_with_closed_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/nasal_helmet_with_closed_mail"
			},
			{
				R = 45,
				P = 1.0,
				S = "helmets/reinforced_mail_coif"
			}
		];
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/legend_enclave_vanilla_skullcap_01"
		});
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/legend_enclave_vanilla_great_helm_01"
		});
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/legend_enclave_vanilla_great_bascinet_01"
		});
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/legend_enclave_vanilla_great_bascinet_02"
		});
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/legend_enclave_vanilla_armet_01"
		});
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/legend_enclave_vanilla_kettle_sallet_01"
		});
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/wallace_sallet"
		});
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/deep_sallet"
		});
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/scale_helm"
		});
		list.push({
			R = 80,
			P = 1.0,
			S = "helmets/rondel_helm"
		});

		foreach( i in this.Const.Items.LegendNamedArmorLayers )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.LegendNamedHelmetLayers )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.NamedArmors )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.NamedHelmets )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		if (this.Const.DLC.Unhold)
		{
			list.push({
				R = 45,
				P = 1.0,
				S = "armor/leather_scale_armor"
			});
			list.push({
				R = 55,
				P = 1.0,
				S = "armor/light_scale_armor"
			});
			list.push({
				R = 90,
				P = 1.0,
				S = "armor/noble_mail_armor"
			});
			list.push({
				R = 60,
				P = 1.0,
				S = "armor/sellsword_armor"
			});
			list.push({
				R = 50,
				P = 1.0,
				S = "armor/footman_armor"
			});
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/sallet_helmet"
			});
			list.push({
				R = 80,
				P = 1.0,
				S = "helmets/barbute_helmet"
			});

			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_metal_plating_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_metal_pauldrons_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_mail_patch_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_leather_shoulderguards_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_leather_neckguard_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_joint_cover_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_heraldic_plates_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_double_mail_upgrade"
			});
		}

		if (this.Const.DLC.Wildmen && this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.7)
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/nordic_helmet"
			});
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/steppe_helmet_with_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/conic_helmet_with_closed_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/conic_helmet_with_closed_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/nordic_helmet_with_closed_mail"
			});
			list.push({
				R = 80,
				P = 1.0,
				S = "helmets/conic_helmet_with_faceguard"
			});
		}
		else
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/flat_top_helmet"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_closed_mail"
			});
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, false);
	}

});
