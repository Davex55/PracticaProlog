%TEST PROLOG

% basic_building()

basic_building([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ]).
      yes
basic_building([[0]]).
      yes
basic_building([[0], [0], [s(0), s(0)]]).
      yes
basic_building([[],[]]).
      no
basic_building([]).
      no
basic_building([ [ s(0), s(s(s(0))), a ], [ 0, s(s(0)) ] ]).
      no
basic_building([ [ s(0), s(s(s(0))), [ 0, s(0) ] ], [ 0, s(s(0)) ] ]).
      no

% building()

% level()

level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(0), [ s(0), s(s(s(0))) ]).
      yes
level([[0, 0], [0, 0], [s(0), s(0)]], s(s(s(0))), [s(0), s(0)]).
      yes
level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(0), [ 0, s(s(0)) ]).
      no
level([[],[]], s(0), []).
      no
level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], 0, [ s(0), s(s(s(0))) ]).
      no
level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], [], [ s(0), s(s(s(0))) ]).
      no
level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(0), a).
      no

% column()

% columns()

% total_people()

% average()
