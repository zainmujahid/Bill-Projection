function billCalculator(Load, PV)
    %   billCalculator calculates the bill by multiplying the difference 
    %   of Load and PV (KWh) with the current Residential Unit Price
    
    unitBuyingPrice = 18.54;    %Considering 301-700 Units Monthly
    unitSellingPrice = 15.67;

    % ============================================================

    if Load > PV                     %Consumption
        units = Load - PV;
        bill= units*unitBuyingPrice;
        fprintf(['Bill of the given month in Rs. ' ...
        'is:\n %f\n\n'], bill); 
    elseif PV > Load                 %Net Metering
        units = PV - Load;
        profit= units*unitSellingPrice;
        fprintf(['Profit earned in the given month Net Metering ' ...
        'is:\n %f\n\n'], profit); 
    else                                             
        bill = 0;
        fprintf(['PV is fullfilling the Load Demand of given month' ,bill]);
    end
    
    % ============================================================

end
