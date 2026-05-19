--!strict
--!nolint LocalShadow

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.fusion)

local function renderMainContent(
	scope: Fusion.Scope<typeof(Fusion)>,
	props: {
		isActive: Fusion.Value<boolean>,
		TextBoxValue: Fusion.Value<string>,
		itemdataSent: Fusion.Value<boolean>,
	}
): Fusion.Child
	local isActive = props.isActive
	local itemdataSent = props.itemdataSent

	local redeemButtonHover = scope:Value(false)
	local redeemButtonHeld = scope:Value(false)
	local exitButtonHover = scope:Value(false)
	local exitButtonHeld = scope:Value(false)

	local TextBoxValue = props.TextBoxValue

	return scope:New("CanvasGroup")({
		Name = "MainContent",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.45),
		Size = UDim2.fromScale(0.65, 0.7),
		BackgroundTransparency = 1,

		GroupTransparency = scope:Spring(
			scope:Computed(function(use)
				return if use(isActive) then 0 else 1
			end),
			30,
			0.7
		),

		[scope.Children] = {
			scope:New("UIScale")({
				Scale = scope:Spring(
					scope:Computed(function(use)
						return if use(isActive) then 1 else 0.1
					end),
					30,
					0.7
				),
			}),

			scope:New("Frame")({
				Name = "Content",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromScale(0.95, 0.95),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BackgroundTransparency = 0.2,

				[scope.Children] = {
					scope:New("UICorner")({ CornerRadius = UDim.new(0.015, 0) }),

					Topbar = scope:New("Frame")({
						Name = "Topbar",
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.fromScale(0.5, 0.075),
						Size = UDim2.fromScale(1, 0.15),
						BackgroundTransparency = 1,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),

						[scope.Children] = {

							Title = scope:New("TextLabel")({
								Name = "Title",
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.3, 0.5),
								Size = UDim2.fromScale(0.5, 0.6),
								BackgroundTransparency = 1,

								Text = "Catalog Buyer",
								TextColor3 = Color3.fromRGB(200, 200, 200),
								Font = Enum.Font.FredokaOne,
								TextScaled = true,
								TextXAlignment = Enum.TextXAlignment.Left,
							}),
							ExitBtn = scope:New("ImageButton")({
								Name = "ExitBtn",
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = scope:Spring(
									scope:Computed(function(use)
										return if use(exitButtonHover)
											then UDim2.fromScale(0.95, 0.4)
											else UDim2.fromScale(0.95, 0.5)
									end),
									30,
									0.6
								),
								Size = UDim2.fromScale(0.6, 0.6),
								BackgroundTransparency = 1,
								ImageColor3 = Color3.fromRGB(200, 200, 200),
								ImageTransparency = 0.3,
								Image = "rbxassetid://16898791349",
								ImageRectOffset = Vector2.new(257, 0),
								ImageRectSize = Vector2.new(256, 256),
								ScaleType = Enum.ScaleType.Stretch,

								[Fusion.OnEvent("Activated")] = function()
									props.isActive:set(false)
								end,
								[Fusion.OnEvent("MouseButton1Down")] = function()
									exitButtonHeld:set(true)
								end,
								[Fusion.OnEvent("MouseButton1Up")] = function()
									exitButtonHeld:set(false)
								end,
								[Fusion.OnEvent("MouseEnter")] = function()
									exitButtonHover:set(true)
								end,
								[Fusion.OnEvent("MouseLeave")] = function()
									exitButtonHover:set(false)
									exitButtonHeld:set(false)
								end,

								[scope.Children] = {
									scope:New("UIAspectRatioConstraint")({ AspectRatio = 1 }),
									scope:New("UIScale")({
										Scale = scope:Spring(
											scope:Computed(function(use)
												return if use(exitButtonHover) and not use(exitButtonHeld)
													then 1.2
													elseif use(exitButtonHeld) then 0.95
													else 1
											end),
											30,
											0.7
										),
									}),
								},
							}),
						},
					}),

					LoadingMenu = scope:New("Frame")({
						Name = "LoadingMenu",
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.fromScale(0.5, 0.57),
						Size = UDim2.fromScale(1, .85),
						BackgroundTransparency = 1,

						Visible = scope:Computed(function(use)
							return use(itemdataSent)
						end),

						[scope.Children] = {
							spinner = scope:New("ImageLabel")({
								Name = "Spinner",
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromScale(0.25, 0.25),
								BackgroundTransparency = 1,
								Image = "rbxassetid://2459243309",
								ImageRectOffset = Vector2.new(0, 0),
								ImageRectSize = Vector2.new(256, 256),
								ScaleType = Enum.ScaleType.Stretch,

								Rotation = scope:Spring(
									scope:Computed(function(use)
										return if use(itemdataSent) then 360 else 0
									end),
									30,
									1
								),

								[scope.Children] = {
									scope:New("UIAspectRatioConstraint")({ AspectRatio = 1 }),
									scope:New("UIScale")({
										Scale = scope:Spring(
											scope:Computed(function(use)
												return if use(itemdataSent) then 1 else 0.1
											end),
											30,
											0.7
										),
									}),
								}
							})
						},
					});

					Main = scope:New("Frame")({
						Name = "Main",
						AnchorPoint = Vector2.new(.5,.5),
						Position = UDim2.fromScale(0.5, .57),
						Size = UDim2.fromScale(1, .85),
						BackgroundTransparency = 1,

						Visible = scope:Computed(function(use)
							return not use(itemdataSent)
						end),

						[scope.Children] = {

                            subTitle1 = scope:New("TextLabel")({
                                Name = "SubTitle1",
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                Position = UDim2.fromScale(0.44 , 0.066),
                                Size = UDim2.fromScale(0.8, 0.1),
                                BackgroundTransparency = 1,

                                Text = "Enter the ID of the item you wish to purchase below.",
                                TextColor3 = Color3.fromRGB(170, 170, 170),
                                Font = Enum.Font.Arial,
                                TextScaled = true,
                            });

                            subPoints = scope:New("Frame")({
                                Name = "SubPoints";
                                AnchorPoint = Vector2.new(0.5, 0.5);
                                Position = UDim2.fromScale(0.44, 0.33);
                                Size = UDim2.fromScale(0.8, 0.4);
                                BackgroundTransparency = 1;

                                [scope.Children] = {
                                    scope:New("UIListLayout")({
                                        FillDirection = Enum.FillDirection.Vertical;
                                        HorizontalAlignment = Enum.HorizontalAlignment.Left;
                                        VerticalAlignment = Enum.VerticalAlignment.Top;
                                        Padding = UDim.new(0.02, 0);
                                    });
                                    
                                    scope:New("TextLabel")({
                                        Name = "Point1";
                                        AnchorPoint = Vector2.new(0, 0);
                                        Position = UDim2.fromScale(0, 0);
                                        Size = UDim2.fromScale(1, 0.3);
                                        BackgroundTransparency = 1;

                                        Text = "• Copy & Paste an Marketplace Item ID into the input box below.";
                                        TextColor3 = Color3.fromRGB(170, 170, 170);
                                        Font = Enum.Font.Arial;
                                        TextScaled = true;
                                        TextXAlignment = Enum.TextXAlignment.Left;
                                    });

                                    scope:New("TextLabel")({
                                        Name = "Point2";
                                        AnchorPoint = Vector2.new(0, 0);
                                        Position = UDim2.fromScale(0, 0);
                                        Size = UDim2.fromScale(1, 0.3);
                                        BackgroundTransparency = 1;

                                        Text = "• Make sure you have enough Robux in your account to purchase the item.";
                                        TextColor3 = Color3.fromRGB(170, 170, 170);
                                        Font = Enum.Font.Arial;
                                        TextScaled = true;
                                        TextXAlignment = Enum.TextXAlignment.Left;
                                    });

									scope:New("TextLabel")({
                                        Name = "Point2";
                                        AnchorPoint = Vector2.new(0, 0);
                                        Position = UDim2.fromScale(0, 0);
                                        Size = UDim2.fromScale(1, 0.3);
                                        BackgroundTransparency = 1;

                                        Text = "• Press the Redeem Button, and enjoy your new item, and save!";
                                        TextColor3 = Color3.fromRGB(170, 170, 170);
                                        Font = Enum.Font.Arial;
                                        TextScaled = true;
                                        TextXAlignment = Enum.TextXAlignment.Left;
                                    });
                                }
                            });

							input_box_bg = scope:New("Frame")({
								Name = "InputBoxBg",
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.65),
								Size = UDim2.fromScale(0.92, 0.15),
								BackgroundColor3 = Color3.fromRGB(25, 25, 25),
								BackgroundTransparency = 0.2,

								[scope.Children] = {
									scope:New("UICorner")({ CornerRadius = UDim.new(0.05, 0) }),

									scope:New("TextBox")({
										Name = "InputBox",
										AnchorPoint = Vector2.new(0.5, 0.5),
										Position = UDim2.fromScale(0.5, 0.5),
										Size = UDim2.fromScale(0.9, 0.4),
										BackgroundTransparency = 1,
										TextColor3 = Color3.fromRGB(61, 61, 61),
										Font = Enum.Font.FredokaOne,
										TextScaled = true,
										PlaceholderText = "Enter item ID here",
										PlaceholderColor3 = Color3.fromRGB(61, 61, 61),
										TextXAlignment = Enum.TextXAlignment.Left,

										[Fusion.OnChange "Text"] = function(newText)
											TextBoxValue:set(newText)
											--print("Text changed:", newText)
										end
									}),
								},
							}),

							redeem = scope:New("ImageButton")({
								Name = "RedeemButton",
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = scope:Spring(
									scope:Computed(function(use)
										return if use(redeemButtonHover)
											then UDim2.fromScale(0.5, 0.85)
											else UDim2.fromScale(0.5, 0.9)
									end),
									30,
									0.7
								),
								Size = UDim2.fromScale(0.25, 0.14),
								BackgroundTransparency = 1,

								[Fusion.OnEvent("Activated")] = function()
									-- handle redeem logic here?
									itemdataSent:set(true)
								end,
								[Fusion.OnEvent("MouseButton1Down")] = function()
									redeemButtonHeld:set(true)
								end,
								[Fusion.OnEvent("MouseButton1Up")] = function()
									redeemButtonHeld:set(false)
								end,
								[Fusion.OnEvent("MouseEnter")] = function()
									redeemButtonHover:set(true)
								end,
								[Fusion.OnEvent("MouseLeave")] = function()
									redeemButtonHover:set(false)
								end,

								[Fusion.Children] = {
									scope:New("UIScale")({
										Scale = scope:Spring(
											scope:Computed(function(use)
												return if use(redeemButtonHover) and not use(redeemButtonHeld)
													then 1.1
													elseif use(redeemButtonHeld) then 0.95
													else 1
											end),
											30,
											0.7
										),
									}),
									scope:New("Frame")({
										Name = "Content",
										AnchorPoint = Vector2.new(0.5, 0.5),
										Position = UDim2.fromScale(0.5, 0.5),
										Size = UDim2.fromScale(1, 1),
										BackgroundColor3 = Color3.fromRGB(10, 10, 10),
										BackgroundTransparency = 0.2,

										[scope.Children] = {
											scope:New("UICorner")({ CornerRadius = UDim.new(0.15, 0) }),

											scope:New("TextLabel")({
												Name = "Text",
												AnchorPoint = Vector2.new(0.5, 0.5),
												Position = UDim2.fromScale(0.5, 0.5),
												Size = UDim2.fromScale(0.75, 0.6),
												BackgroundTransparency = 1,

												Text = "Redeem",
												TextColor3 = Color3.fromRGB(170, 170, 170),
												Font = Enum.Font.FredokaOne,
												TextScaled = true,
												TextTransparency = 0.2,
											}),
										},
									}),
								},
							}),
						},
					}),
				},
			}),
		},
	})
end

return renderMainContent
