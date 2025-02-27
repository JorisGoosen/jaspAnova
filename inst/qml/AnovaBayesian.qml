//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

import QtQuick
import JASP
import JASP.Controls
import "./common" as Common
import "./common/bayesian" as Bayesian

Form
{
	id: form
	property int analysis:	Common.Type.Analysis.ANOVA
	property int framework:	Common.Type.Framework.Bayesian

	Formula
	{
		lhs: "dependent"
		rhs: [{ name: "modelTerms", extraOptions: "isNuisance" }]
		userMustSpecify: "randomFactors"
	}

	VariablesForm
	{
		AvailableVariablesList	{ name: "allVariablesList"																							}
		AssignedVariablesList	{ name: "dependent";		title: qsTr("Dependent Variable");	suggestedColumns: ["scale"]; singleVariable: true	}
		AssignedVariablesList	{ name: "fixedFactors";		title: qsTr("Fixed Factors");		suggestedColumns: ["ordinal", "nominal"]			}
		AssignedVariablesList	{ name: "randomFactors";	title: qsTr("Random Factors");		suggestedColumns: ["ordinal", "nominal"]			}
	}

	Bayesian.DefaultOptions { matchedModelsEnabled: additionalOptions.marginalityEnforced	}

	Bayesian.ModelTerms { source: ["fixedFactors", "randomFactors"] }

	Bayesian.SingleModelInference { source: ["fixedFactors", "randomFactors"] }

	Bayesian.PostHocTests { source: "fixedFactors" }

	Bayesian.DescriptivesPlots { source: "fixedFactors" }

	Common.RainCloudPlots { source: ["fixedFactors", "randomFactors"] }

	Bayesian.AdditionalOptions { analysis: form.analysis; id: additionalOptions }

}
