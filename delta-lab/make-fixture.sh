#!/bin/sh
# Build the guide's fixture repository: a tiny garden planner with a
# short, deliberate history. Usage: make-fixture.sh <target-dir>
set -eu
DIR="${1:?usage: make-fixture.sh <target-dir>}"
mkdir -p "$DIR"
cd "$DIR"
git init -q -b main
git config user.name "Pat Gardener"
git config user.email "pat@example.org"
git config commit.gpgsign false

cat > README.md <<'EOF'
# Garden Planner

A tiny notebook for a vegetable garden:
what was planted, where, and when to water.

## Beds

- North bed: tomatoes and peppers.
- South bed: beans and squash.

Water in the morning, before the sun is high.
EOF

cat > garden.py <<'EOF'
#!/usr/bin/env python3
"""Garden planner: beds, seeds and watering."""

BEDS = {
    "north": ["tomatoes", "peppers"],
    "south": ["beans", "squash"],
}

WATER_LITRES_PER_BED = 6


def watering_plan(day):
    if day in ("Saturday", "Sunday"):
        return "Water every bed deeply."
    return "Check the soil and water if dry."


def main():
    for bed, crops in BEDS.items():
        print(f"{bed}: {', '.join(crops)}")
    print(watering_plan("Saturday"))


if __name__ == "__main__":
    main()
EOF

cat > watering.sh <<'EOF'
#!/bin/sh
# Water the beds listed on the command line.
for bed in "$@"; do
    echo "Watering $bed"
done
EOF

cat > notes.txt <<'EOF'
Spring notes

Order more twine.
The fence post by the gate leans a little more each year.
Ask the neighbour about the spare cold frame.
EOF

git add -A
git commit -qm "Start the garden planner"

# Commit 2: small within-line edits in code and prose.
sed -i 's/WATER_LITRES_PER_BED = 6/WATER_LITRES_PER_BED = 4/' garden.py
sed -i 's/if day in ("Saturday", "Sunday"):/if day in ("Saturday",):/' garden.py
sed -i 's/return "Water every bed deeply."/return "Water every bed deeply, twice."/' garden.py
sed -i 's/Water in the morning, before the sun is high./Water in the early morning, before the sun is high./' README.md
git commit -qam "Water less at a time, and only deep-water on Saturdays"

# Commit 3: an addition, a deletion, a rename, a mode change.
cat > seeds.csv <<'EOF'
seed,bed,month
tomato,north,March
pepper,north,April
bean,south,May
squash,south,May
EOF
git rm -q notes.txt
git mv watering.sh irrigation.sh
sed -i 's/# Water the beds listed on the command line./# Water the beds named on the command line./' irrigation.sh
chmod +x garden.py
git add -A
git commit -qm "Seeds list, rename the watering script, make the planner executable"

# A binary file changes too (a "photo" of the gate, in two versions).
printf 'GARDENPHOTO\000\001\002\003draft' > gate.bin
git add gate.bin
git commit -qm "Add a photo of the gate"
printf 'GARDENPHOTO\000\011\010\007\006final-scan-higher-resolution' > gate.bin
git commit -qam "Replace the gate photo with a better scan"

# Branch, disagree, and merge into a conflict (left unresolved on
# purpose when CONFLICT=1 is in the environment; default resolves by
# aborting so the repository ends clean).
git checkout -q -b winter HEAD~2
sed -i 's/WATER_LITRES_PER_BED = 4/WATER_LITRES_PER_BED = 2/' garden.py
sed -i 's/return "Water every bed deeply, twice."/return "In winter, barely water at all."/' garden.py
git commit -qam "Winter watering: barely at all"
git checkout -q main
sed -i 's/WATER_LITRES_PER_BED = 4/WATER_LITRES_PER_BED = 3/' garden.py
git commit -qam "Split the difference: three litres a bed"
if git merge winter --no-edit > /dev/null 2>&1; then
    echo "expected a conflict, got a clean merge" >&2
    exit 1
fi
if [ "${CONFLICT:-0}" = "1" ]; then
    echo "Left mid-merge: garden.py is conflicted."
else
    git merge --abort
    git branch -D winter > /dev/null
    git log --oneline | head -3 > /dev/null
    echo "Conflict rehearsed and aborted; repository is clean."
fi
