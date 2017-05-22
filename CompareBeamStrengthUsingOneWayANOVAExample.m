%% Compare Beam Strength Using One-Way ANOVA
% Input the sample data.

% Copyright 2015 The MathWorks, Inc.

strength = [82 86 79 83 84 85 86 87 74 82 ...
            78 75 76 77 79 79 77 78 82 79];
alloy = {'st','st','st','st','st','st','st','st',...
         'al1','al1','al1','al1','al1','al1',...
         'al2','al2','al2','al2','al2','al2'};
%%
% The data are from a study of the strength of structural beams in Hogg
% (1987). The vector strength measures deflections of beams in thousandths
% of an inch under 3000 pounds of force. The vector alloy identifies each
% beam as steel (|'st'|), alloy 1 (|'al1'|), or alloy 2 (|'al2'|). Although alloy
% is sorted in this example, grouping variables do not need to be sorted.
%%
% Test the null hypothesis that the steel beams are equal in strength to
% the beams made of the two more expensive alloys. Turn the figure display
% off and return the ANOVA results in a cell array.
[p,tbl] = anova1(strength,alloy,'off')
%%
% The total degrees of freedom is total number of observations minus one,
% which is  $$ 20 - 1 = 19 $$. The between-groups degrees of freedom is
% number of groups minus one, which is $$ 3 - 1 = 2 $$. The within-groups
% degrees of freedom is total degrees of freedom minus the between groups
% degrees of freedom, which is $$ 19 - 2 = 17 $$.
%%
% |MS| is the mean squared error, which is |SS/df| for each source of
% variation. The _F_-statistic is the ratio of the mean squared errors. The
% _p_-value is the probability that the test statistic can take a value
% greater than or equal to the value of the test statistic. The _p_-value
% of 1.5264e-04 suggests rejection of the null hypothesis.
%% 
% You can retrieve the values in the ANOVA table by indexing into the cell
% array. Save the _F_-statistic value and the _p_-value in the new variables
% |Fstat| and |pvalue|.
Fstat = tbl{2,5}
pvalue = tbl{2,6}



