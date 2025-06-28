TestCreate[
  Needs["ChristopherWolfram`GEOSGeometry`"],
  Null
]

poly1 = Uncompress["1:eJxTTMoPSmNiYGAoZgcSAfk5len5eakgAT4gBtEdfWdOfXS6ac9TMln0188r9lkZPRo\
tH57bM22dozz9ymP7WVZOUy6feWyvctAmoTnxtv2MNZ/f3RV+aq/Rs29+ne4te7EnEja3S\
x7bPzh9ee2rFZft1xx9acjo9tTe43pGOf/bQ/ZbOD5oOOu/tU8p6w0t2P7CPubFYuWO/2/t\
12S8WL7Y7I29RFfcqSqj9/Zyp5dt6vvxzr7s5tr6RVLP7fOmiNooHHxlv+aNHFd8/GX7nO\
mOJ5mY3tjrLf+0+cndx/Z6aZclt914bH/kZXtyhtJl+wcM7pcmWN6yjyg6cc9oy3H7Dd8X\
J0w+cdI+DeTRYhYg4ZNZXOLJCGQYgkkjMGkMJk3ApCmYNAOT5mDSAkxaeoICytAAQhlCKC\
MIZQyhTADqoYar"];

TestCreate[
  geom1 = GEOSGeometry[poly1];
  MatchQ[geom1, _GEOSGeometry]
]

TestCreate[
  Area[poly1] == GEOSArea[geom1]
]