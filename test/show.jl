@test sprint(show, "text/plain", LPLossOnVectors()) == "LPLossOnVectors(\n  p = 2)"
@test sprint(show, LPLossOnVectors()) == "LPLossOnVectors(p = 2)"
