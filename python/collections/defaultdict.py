from collections import defaultdict
from typing import List, Tuple, DefaultDict
listed: List[Tuple[int, str]] = [
    (1, "1"),
    (2, "2"),
    (2, "3"),
]
as_defaultdict: DefaultDict[int, str] = defaultdict(
    lambda: "",
    listed,
)
print(as_defaultdict.keys())
print([each for each in as_defaultdict.keys()])
print([each for each in as_defaultdict.values()])
