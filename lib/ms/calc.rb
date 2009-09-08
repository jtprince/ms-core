module Ms
  module Calc 
      module_function
    
      #
      # ppm calculations... maybe use RUnit
      #
  
      def ppm_tol_at(mz, ppm)
        1.0 * mz * ppm / 10**6
      end

      def ppm_span_at(mz, ppm)
        tol = ppm_tol_at(mz, ppm)
        [mz-tol, mz+tol]
      end
  
      def ppm_range_at(mz, ppm)
        mz = mz.to_f
        tol = ppm_tol_at(mz, ppm)
        mz-tol...mz+tol
      end

      # Rounds n to the specified precision (ie number of decimal places)
      def round(n, precision)
        factor = 10**precision.to_i
        (n * factor).round.to_f / factor
      end
  end
end
