/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2015
 * 
 *  @Author:		Overhype Studios
 *  @Date:			03.03.2015
 *  @Description:	New Campaign Menu Module JS
 */
"use strict";

var NewCampaignMenuModule = function ()
{
	this.mSQHandle = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;

	this.mFirstPanel = null;
	this.mSecondPanel = null;
	this.mThirdPanel = null;

	// controls
	this.mDifficultyEasyCheckbox = null;
	this.mDifficultyEasyLabel = null;
	this.mDifficultyNormalCheckbox = null;
	this.mDifficultyNormalLabel = null;
	this.mDifficultyHardCheckbox = null;
	this.mDifficultyHardLabel = null;
	this.mDifficultyLegendaryCheckbox = null;
	this.mDifficultyLegendaryLabel = null;

	this.mEconomicDifficultyEasyCheckbox = null;
	this.mEconomicDifficultyEasyLabel = null;
	this.mEconomicDifficultyNormalCheckbox = null;
	this.mEconomicDifficultyNormalLabel = null;
	this.mEconomicDifficultyHardCheckbox = null;
	this.mEconomicDifficultyHardLabel = null;
	this.mEconomicDifficultyLegendaryCheckbox = null;
	this.mEconomicDifficultyLegendaryLabel = null;

	this.mBudgetDifficultyEasyCheckbox = null;
	this.mBudgetDifficultyEasyLabel = null;
	this.mBudgetDifficultyNormalCheckbox = null;
	this.mBudgetDifficultyNormalLabel = null;
	this.mBudgetDifficultyHardCheckbox = null;
	this.mBudgetDifficultyHardLabel = null;
	this.mBudgetDifficultyLegendaryCheckbox = null;
	this.mBudgetDifficultyLegendaryLabel = null;

	this.mIronmanCheckbox = null;
	this.mIronmanCheckboxLabel = null;
	this.mCompanyName = null;

	this.mEvilRandomCheckbox = null;
	this.mEvilRandomLabel = null;
	this.mEvilWarCheckbox = null;
	this.mEvilWarLabel = null;
	this.mEvilGreenskinsCheckbox = null;
	this.mEvilGreenskinsLabel = null;
	this.mEvilUndeadCheckbox = null;
	this.mEvilUndeadLabel = null;
	this.mEvilCrusadeCheckbox = null;
	this.mEvilCrusadeLabel = null;
	this.mEvilCrusadeControl = null;
	this.mEvilNoneCheckbox = null;
	this.mEvilNoneLabel = null;
	this.mEvilNoDesctructionCheckbox = null;
	this.mEvilPermanentDestructionLabel = null;

	this.mPrevBannerButton = null;
	this.mNextBannerButton = null;
	this.mBannerImage = null;

	this.mSeed = null;

	// buttons
	this.mStartButton = null;
	this.mCancelButton = null;

	// banners
	this.mBanners = null;
	this.mCurrentBannerIndex = 0;

	// difficulty
	this.mDifficulty = 3;
	this.mEconomicDifficulty = 3;
	this.mBudgetDifficulty = 3;
	this.mEvil = 0;

	// scenario
	this.mScenarios = null;
	this.mSelectedScenario = 0;
	this.mScenariosRow = null;

	// generics
	this.mIsVisible = false;
};


NewCampaignMenuModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

NewCampaignMenuModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

NewCampaignMenuModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


NewCampaignMenuModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: dialog container
	this.mContainer = $('<div class="new-campaign-menu-module display-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('New Campaign', null, null /*Path.GFX + Asset.HEADER_TACTICAL_COMBAT_DIALOG*/, false, 'dialog-800-720-2');

	// create: content
	var contentContainer = this.mDialogContainer.findDialogContentContainer();

	this.mSecondPanel = $('<div class="display-block"/>');
	contentContainer.append(this.mSecondPanel);

		var leftColumn = $('<div class="column"/>');
		this.mSecondPanel.append(leftColumn);
		var rightColumn = $('<div class="column"/>');
		this.mSecondPanel.append(rightColumn);

	this.mThirdPanel = $('<div class="display-none"/>');
	contentContainer.append(this.mThirdPanel);

		var leftColumn = $('<div class="column"/>');
		this.mThirdPanel.append(leftColumn);
		var rightColumn = $('<div class="column"/>');
		this.mThirdPanel.append(rightColumn);

		// name
		var row = $('<div class="row" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Company Name</div>');
		row.append(title);

		var inputLayout = $('<div class="l-input"/>');
		row.append(inputLayout);
		this.mCompanyName = inputLayout.createInput('Battle Brothers', 0, 32, 1, function (_input)
		{
			if(self.mStartButton !== null) self.mStartButton.enableButton(_input.getInputTextLength() >= 1);
		}, 'title-font-big font-bold font-color-brother-name'); 
		this.mCompanyName.setInputText('Battle Brothers');

		// Difficulty
		var row = $('<div class="row" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Difficulty</div>');
		row.append(title);

		var LegendaryDifficultyControl = $('<div class="control"></div>');
		row.append(LegendaryDifficultyControl);
		this.mEconomicDifficultyLegendaryCheckbox = $('<input type="radio" id="cb-economic-difficulty-Legendary" name="economic-difficulty" />');
		LegendaryDifficultyControl.append(this.mEconomicDifficultyLegendaryCheckbox);
		this.mEconomicDifficultyLegendaryLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-economic-difficulty-Legendary">Standard</label>');
		LegendaryDifficultyControl.append(this.mEconomicDifficultyLegendaryLabel);
		this.mEconomicDifficultyLegendaryCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});

		// seed
		var row = $('<div class="row map-seed-control" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Map Seed</div>');
		row.append(title);

		var inputLayout = $('<div class="l-input"/>');
		row.append(inputLayout);
		this.mSeed = inputLayout.createInput('', 0, 10, 1, null, 'title-font-big font-bold font-color-brother-name');

		// banner
		var row = $('<div class="row" />');
		rightColumn.append(row);
		//var title = $('<div class="title title-font-big font-color-title">Banner</div>');
		//row.append(title);

		var bannerContainer = $('<div class="banner-container" />');
		row.append(bannerContainer);

		var table = $('<table width="100%" height="100%"><tr><td width="10%"><div class="l-button prev-banner-button" /></td><td width="80%" class="banner-image-container"></td><td width="10%"><div class="l-button next-banner-button" /></td></tr></table>');
		bannerContainer.append(table);

		var prevBanner = table.find('.prev-banner-button:first');
		this.mPrevBannerButton = prevBanner.createImageButton(Path.GFX + Asset.BUTTON_PREVIOUS_BANNER, function ()
		{
			self.onPreviousBannerClicked();
		}, '', 6);

		var nextBanner = table.find('.next-banner-button:first');
		this.mNextBannerButton = nextBanner.createImageButton(Path.GFX + Asset.BUTTON_NEXT_BANNER, function ()
		{
			self.onNextBannerClicked();
		}, '', 6);

		var bannerImage = table.find('.banner-image-container:first');
		this.mBannerImage = bannerImage.createImage(Path.GFX + 'ui/banners/banner_01.png', function (_image)
		{
			_image.removeClass('display-none').addClass('display-block');
			//_image.centerImageWithinParent();
		}, null, 'display-none banner-image');

		
	this.mFirstPanel = $('<div class="display-none"/>');
	contentContainer.append(this.mFirstPanel);

		var leftColumn = $('<div class="column2"/>');
		this.mFirstPanel.append(leftColumn);
		var rightColumn = $('<div class="column3"/>');
		this.mFirstPanel.append(rightColumn);

		// starting scenario
		var row = $('<div class="row" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Company Origin</div>');
		row.append(title);

		var listContainerLayout = $('<div class="l-list-container"/>');
		row.append(listContainerLayout);
		this.mScenarioListContainer = listContainerLayout.createList(5, null, true);
		this.mScenarioListScrollContainer = this.mScenarioListContainer.findListScrollContainer();

		var row = $('<div class="row4" />');
		this.mScenarioListScrollContainer.append(row);
		this.mScenariosRow = row;

		var row = $('<div class="row3 text-font-medium font-color-description" />');
		rightColumn.append(row);
		this.mScenariosDesc = row;

		this.mScenariosDifficulty = row.createImage('', function (_image) { _image.removeClass('display-none').addClass('display-block'); }, null, 'display-none difficulty');
		rightColumn.append(this.mScenariosDifficulty);

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"></div>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	var layout = $('<div class="l-ok-button"/>');
	footerButtonBar.append(layout);
	this.mStartButton = layout.createTextButton("Next", function ()
	{
		//Rewrite logic so that Panel 1 -> 3
		if(self.mFirstPanel.hasClass('display-block'))
		{
			self.mFirstPanel.removeClass('display-block').addClass('display-none');
			self.mThirdPanel.addClass('display-block').removeClass('display-none');
			self.mCancelButton.changeButtonText("Previous");
			self.mStartButton.enableButton(self.mCompanyName.getInputTextLength() >= 1);
			self.mStartButton.changeButtonText("Start");
		}
		else
		{
			self.notifyBackendStartButtonPressed();
		}		
	}, '', 1);

	layout = $('<div class="l-cancel-button"/>');
	footerButtonBar.append(layout);
	this.mCancelButton = layout.createTextButton("Cancel", function ()
	{
		//Rewrite logic so that Panel 1 <- 3
		if(self.mFirstPanel.hasClass('display-block'))
		{
			self.notifyBackendCancelButtonPressed();
		}
		else if(self.mThirdPanel.hasClass('display-block'))
		{
			self.mFirstPanel.addClass('display-block').removeClass('display-none');
			self.mThirdPanel.removeClass('display-block').addClass('display-none');
			self.mStartButton.changeButtonText("Next");
			self.mCancelButton.changeButtonText("Cancel");
			self.mStartButton.enableButton(true);
		}
	}, '', 1);

	this.mIsVisible = false;
};

NewCampaignMenuModule.prototype.destroyDIV = function ()
{
	// controls
	this.mDifficultyEasyCheckbox.remove();
	this.mDifficultyEasyCheckbox = null;
	this.mDifficultyEasyLabel.remove();
	this.mDifficultyEasyLabel = null;
	this.mDifficultyNormalCheckbox.remove();
	this.mDifficultyNormalCheckbox = null;
	this.mDifficultyNormalLabel.remove();
	this.mDifficultyNormalLabel = null;
	this.mDifficultyHardCheckbox.remove();
	this.mDifficultyHardCheckbox = null;
	this.mDifficultyHardLabel.remove();
	this.mDifficultyHardLabel = null;
	this.mDifficultyLegendaryCheckbox.remove();
	this.mDifficultyLegendaryCheckbox = null;
	this.mDifficultyLegendaryLabel.remove();
	this.mDifficultyLegendaryLabel = null;
	this.mCompanyName.remove();
	this.mCompanyName = null;

	this.mPrevBannerButton.remove();
	this.mPrevBannerButton = null;
	this.mNextBannerButton.remove();
	this.mNextBannerButton = null;
	this.mBannerImage.remove();
	this.mBannerImage = null;

	this.mSeed.remove();
	this.mSeed = null;

	// buttons
	this.mStartButton.remove();
	this.mStartButton = null;
	this.mCancelButton.remove();
	this.mCancelButton = null;

	this.mFirstPanel.empty();
	this.mFirstPanel.remove();
	this.mFirstPanel = null;

	this.mSecondPanel.empty();
	this.mSecondPanel.remove();
	this.mSecondPanel = null;

	this.mThirdPanel.empty();
	this.mThirdPanel.remove();
	this.mThirdPanel = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


NewCampaignMenuModule.prototype.bindTooltips = function ()
{
	// Legends
	this.mEconomicDifficultyLegendaryLabel.bindTooltip({
		contentType: 'ui-element',
		elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyLegendary
	});
	this.mEconomicDifficultyLegendaryCheckbox.bindTooltip({
		contentType: 'ui-element',
		elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyLegendary
	});

	// Vanilla
	this.mCompanyName.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.CompanyName });
	this.mSeed.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.Seed });

};

NewCampaignMenuModule.prototype.unbindTooltips = function ()
{
	// Legends
	this.mEconomicDifficultyLegendaryLabel.unbindTooltip();
	this.mEconomicDifficultyLegendaryCheckbox.unbindTooltip();

	// Vanilla
	this.mCompanyName.unbindTooltip();
	this.mSeed.unbindTooltip();
};


NewCampaignMenuModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

NewCampaignMenuModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


NewCampaignMenuModule.prototype.register = function (_parentDiv)
{
	console.log('NewCampaignMenuModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register New Campaign Menu Module. Reason: New Campaign Menu Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

NewCampaignMenuModule.prototype.unregister = function ()
{
	console.log('NewCampaignMenuModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister New Campaign Menu Module. Reason: New Campaign Menu Module is not initialized.');
		return;
	}

	this.destroy();
};

NewCampaignMenuModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


NewCampaignMenuModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


NewCampaignMenuModule.prototype.show = function ()
{
	// reseed
	//this.mSeed.setInputText(Math.round(Math.random() * 9999999).toString(16));

	var seed = "";
	var characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	for(var i = 0; i < 10; i++)
		seed += characters.charAt(Math.floor(Math.random() * characters.length));

	this.mSeed.setInputText(seed);

	// reset panels
	this.mFirstPanel.addClass('display-block').removeClass('display-none');
	this.mSecondPanel.removeClass('display-block').addClass('display-none');
	this.mThirdPanel.removeClass('display-block').addClass('display-none');
	this.mStartButton.changeButtonText("Next");
	this.mCancelButton.changeButtonText("Cancel");

	var self = this;

	var offset = -(this.mContainer.parent().width() + this.mContainer.width());
	this.mContainer.css({ 'left' : offset });
	this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' },
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			$(this).removeClass('display-none').addClass('display-block');
			self.notifyBackendModuleAnimating();
		},
		complete: function ()
		{
			self.mIsVisible = true;
			self.notifyBackendModuleShown();
		}
	});
};

NewCampaignMenuModule.prototype.hide = function ()
{
	var self = this;

	var offset = -(this.mContainer.parent().width() + this.mContainer.width());
	this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			self.notifyBackendModuleAnimating();
		},
		complete: function ()
		{
			self.mIsVisible = false;
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendModuleHidden();
		}
	});
};

NewCampaignMenuModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};


NewCampaignMenuModule.prototype.onPreviousBannerClicked = function()
{
	--this.mCurrentBannerIndex;

	if(this.mCurrentBannerIndex < 0)
		this.mCurrentBannerIndex = this.mBanners.length - 1;

	this.mBannerImage.attr('src', Path.GFX + 'ui/banners/' + this.mBanners[this.mCurrentBannerIndex] + '.png');
};


NewCampaignMenuModule.prototype.onNextBannerClicked = function()
{
	++this.mCurrentBannerIndex;

	if(this.mCurrentBannerIndex >= this.mBanners.length)
		this.mCurrentBannerIndex = 0;

	this.mBannerImage.attr('src', Path.GFX + 'ui/banners/' + this.mBanners[this.mCurrentBannerIndex] + '.png');
};


NewCampaignMenuModule.prototype.setBanners = function(_data)
{
	if(_data !== null && jQuery.isArray(_data))
	{
		this.mBanners = _data;
		this.mCurrentBannerIndex = Math.floor(Math.random() * _data.length);

		this.mBannerImage.attr('src', Path.GFX + 'ui/banners/' + _data[this.mCurrentBannerIndex] + '.png');
	}
	else
	{
		console.error('ERROR: No banners specified for NewCampaignMenu::setBanners');
	}
}


NewCampaignMenuModule.prototype.setStartingScenarios = function (_data)
{
	if (_data !== null && jQuery.isArray(_data))
	{
		this.mScenarios = _data;

		for (var i = 0; i < _data.length; ++i)
		{
			this.addStartingScenario(i, _data[i], this.mScenariosRow);
		}
	}
}


NewCampaignMenuModule.prototype.setCrusadeCampaignVisible = function (_data)
{
	if(_data)
	{
		this.mEvilCrusadeControl.addClass('display-block').removeClass('display-none');
	}
	else
	{
		this.mEvilCrusadeControl.removeClass('display-block').addClass('display-none');
	}
}


NewCampaignMenuModule.prototype.addStartingScenario = function (_index, _data, _row)
{
	var self = this;

	var control = $('<div class="control"></div>');
	this.mScenariosRow.append(control);

	var radioButton = $('<input type="radio" id="cb-scenario-' + _index + '" name="scenario" ' + (_index == 0 ? 'checked' : '') + '/>');
	control.append(radioButton);

	var label = $('<label class="text-font-normal font-color-subtitle" for="cb-scenario-' + _index + '">' + _data.Name + '</label>');
	control.append(label);

	label.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.StartingScenario });

	radioButton.iCheck(
	{
		checkboxClass: 'icheckbox_flat-orange',
		radioClass: 'iradio_flat-orange',
		increaseArea: '30%'
	});

	radioButton.on('ifChecked', null, this, function (_event)
	{
		var self = _event.data;
		self.mSelectedScenario = _index;
		self.updateStartingScenarioDescription(_data.Description, _data.Difficulty);
	});

	if(_index == 0)
		this.updateStartingScenarioDescription(_data.Description, _data.Difficulty);
}


NewCampaignMenuModule.prototype.updateStartingScenarioDescription = function (_desc, _difficulty)
{
	var parsedText = XBBCODE.process(
	{
		text: _desc,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});
									
	this.mScenariosDesc.html(parsedText.html);
	this.mScenariosDifficulty.attr('src', Path.GFX + 'ui/images/' + _difficulty + '.png');
};


NewCampaignMenuModule.prototype.collectSettings = function()
{
	var settings = [];

	// company name
	settings.push(this.mCompanyName.getInputText());

	// banner
	settings.push(this.mBanners[this.mCurrentBannerIndex]);

	// difficulty
	settings.push(this.mDifficulty);
	settings.push(this.mEconomicDifficulty);
	settings.push(this.mBudgetDifficulty);
	settings.push(false);
	settings.push(false);
	settings.push(this.mEvil);
	settings.push(false);
	settings.push(this.mSeed.getInputText());

	// starting scenario
	settings.push(this.mScenarios[this.mSelectedScenario].ID);

	return settings;
}

NewCampaignMenuModule.prototype.notifyBackendModuleShown = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onModuleShown');
	}
};

NewCampaignMenuModule.prototype.notifyBackendModuleHidden = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onModuleHidden');
	}
};

NewCampaignMenuModule.prototype.notifyBackendModuleAnimating = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onModuleAnimating');
	}
};

NewCampaignMenuModule.prototype.notifyBackendStartButtonPressed = function ()
{
	if (this.mSQHandle !== null)
	{
		var settings = this.collectSettings();
		SQ.call(this.mSQHandle, 'onStartButtonPressed', settings);
	}
};

NewCampaignMenuModule.prototype.notifyBackendCancelButtonPressed = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onCancelButtonPressed');
	}
};
