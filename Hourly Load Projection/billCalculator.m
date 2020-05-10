function billCalculator(Load, PV)
    %   billCalculator calculates the bill by multiplying the difference 
    %   of Load and PV (KWh) with the current Residential Unit Price
    
    unitBuyingPrice = 18.54;    %Considering 301-700 Units Monthly
    unitSellingPrice = 15.67;

    % ============================================================

    if Load > PV                     %Consumption
        units = Load - PV;
        bill= units*unitBuyingPrice;
        fprintf(['Bill for the hour in Rs at given Date, Time, ' ...
        'PV, Temp is:\n %f\n\n'], bill); 
    elseif PV > Load                 %Net Metering
        units = PV - Load;
        profit= units*unitSellingPrice;
        fprintf(['Profit earned for the hour in Rs by Net Metering at ' ...
        'given Date, Time, PV, Temp is:\n %f\n\n'], profit); 
    else                                             
        bill = 0;
        fprintf(['PV is fullfilling the load demand of given hour' ,bill]);
    end
    
    % ============================================================

end
