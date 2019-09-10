# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class UserInterface
        module Controller
          # Audio::UserInterface::Controller::AudioController
          class AudioController < SDK::UIKit::Controller::BaseController
            NAME = 'Controller::Audio'

            attr_reader :target, :addressed_player
            alias player addressed_player

            # LOGGER = LogActually.audio

            def name
              NAME
            end

            # 'Pages' ------------------------------------------------------

            def index
              LOGGER.debug(NAME) { '#index' }
              @view = View::Index.new(@target)
              view.add_observer(self)
              render(view)
            end

            def targets
              LOGGER.debug(NAME) { '#targets' }
              @view = View::Targets.new(@targets)
              view.add_observer(self)
              render(view)
            end

            def now_playing
              LOGGER.debug(NAME) { '#now_playing' }
              @view = View::NowPlaying.new(@player)
              view.add_observer(self)
              render(view)
            end

            # Setup ------------------------------------------------------

            def create(view)
              LOGGER.debug(NAME) { "#create(#{view})" }
              case view
              when :index
                @target = context.audio.target
                @target.add_observer(self, :target_update)
                true
              when :targets
                @targets = context.audio.targets
                true
              when :now_playing
                @target = context.audio.target
                @target.add_observer(self, :target_update)

                @player = @target.addressed_player
                @player.add_observer(self, :player_update)
                true
              else
                LOGGER.warn(NAME) { "Create: #{view} view not recognised." }
                false
              end
            end

            def destroy
              LOGGER.debug(NAME) { "#destroy(#{loaded_view})" }
              case loaded_view
              when :index
                @target&.delete_observer(self)
                @target = nil
                true
              when :targets
                @targets = nil
              when :now_playing
                @target&.delete_observer(self)
                @target = nil
                @player&.delete_observer(self)
                @player = nil
                true
              else
                LOGGER.warn(NAME) { "Destroy: #{loaded_view} view not recognised." }
                false
              end
              @view&.delete_observer(self)
              @view = nil
            end

            # USER EVENTS ------------------------------------------------------

            # selected_menu_item may just be button state for non data request
            def update(action, selected_menu_item = nil)
              LOGGER.debug(NAME) { "#update(#{action}, #{selected_menu_item&.id || selected_menu_item})" } if selected_menu_item
              LOGGER.debug(NAME) { "#update(#{action})" } unless selected_menu_item
              case action
              when :main_menu_index
                ui_context.launch(:services, :index)
              when :audio_now_playing
                ui_context.launch(:audio, :now_playing)
              when :audio_index
                ui_context.launch(:audio, :index)
              when :audio_targets
                ui_context.launch(:audio, :targets)
              when :audio_select_target
                LOGGER.debug(NAME) { "#audio_select_target(#{action})" }
                # selected_target = target_from_menu_item(selected_menu_item)
                context.audio.targets.select_target(selected_menu_item.id)
                ui_context.launch(:audio, :index)
              when :audio_play
                context.audio.play!
              when :audio_pause
                context.audio.pause!
              else
                LOGGER.debug(NAME) { "#update: #{action} not implemented." }
              end
            end

            # DATA EVENTS ------------------------------------------------------

            def target_update(action, target:)
              LOGGER.debug(NAME) { "#target_update(#{action}, #{target})" }
              case action
              when :added
                @view&.reinitialize(@target)
                update_menu(view)
              when :changed
                @view&.reinitialize(@target)
                update_menu(view)
              when :removed
                @view&.reinitialize(@target)
                update_menu(view)
              end
            end

            def player_update(action, player:)
              LOGGER.debug(NAME) { "#player_update(#{action}, #{player})" }
              case action
              when :track_pending
                @view&.reinitialize(@player)
                update_view(view)
              when :track_change
                @view&.reinitialize(@player)
                update_view(view)
              when :track_start
                @view&.reinitialize(@player)
                update_view(view)
              when :position
                @view&.reinitialize(@player)
                update_view(view)
              when :status
                @view&.reinitialize(@player)
                update_view(view)
              end
            end

            private

            def target_from_menu_item(selected_menu_item)
              LOGGER.debug(NAME) { "#target_from_menu_item(#{selected_menu_item})" }
              id = selected_menu_item.id
              LOGGER.debug(NAME) { "Target Address: #{id}" }
              target_object = context.audio.targets.find_by_id(id)
              LOGGER.debug(NAME) { "Target => #{target_object}" }
              target_object
            end
          end
        end
      end
    end
  end
end
