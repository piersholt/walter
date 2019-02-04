class Virtual
  class Display
    # External device has priority. Do not draw/refresh display
    # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
    class Busy
      def user_input(context, method, properties)
        return false
      end

      def render_menu(context, view)
        return false
      end
    end
  end
end
