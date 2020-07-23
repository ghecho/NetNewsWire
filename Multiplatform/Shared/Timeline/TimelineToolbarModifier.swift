//
//  TimelineToolbarModifier.swift
//  NetNewsWire
//
//  Created by Maurice Parker on 7/5/20.
//  Copyright © 2020 Ranchero Software. All rights reserved.
//

import SwiftUI

struct TimelineToolbarModifier: ViewModifier {
	
	@EnvironmentObject private var sceneModel: SceneModel
	@EnvironmentObject private var timelineModel: TimelineModel

	func body(content: Content) -> some View {
		content
			.toolbar {
				#if os(iOS)
				ToolbarItem(placement: .primaryAction) {
					Button {
						withAnimation {
							timelineModel.toggleReadFilter()
						}
					} label: {
						if timelineModel.isReadFiltered ?? false {
							AppAssets.filterActiveImage.font(.title3)
						} else {
							AppAssets.filterInactiveImage.font(.title3)
						}
					}
					.hidden(timelineModel.isReadFiltered == nil)
					.help(timelineModel.isReadFiltered ?? false ? "Show Read Articles" : "Filter Read Articles")
				}
				
				ToolbarItem(placement: .bottomBar) {
					Button {
						sceneModel.markAllAsRead()
					} label: {
						AppAssets.markAllAsReadImage
					}
					.disabled(sceneModel.markAllAsReadButtonState == nil)
					.help("Mark All As Read")
				}
				
				ToolbarItem(placement: .bottomBar) {
					Spacer()
				}
				#endif
			}
	}
	
}
