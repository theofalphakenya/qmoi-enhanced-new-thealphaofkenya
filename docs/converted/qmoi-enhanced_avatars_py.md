"""Sanitized stub for `qmoi-enhanced/avatars.py`.

Original content moved to `docs/converted/qmoi__avatars.md`.
This file intentionally contains only a small helper so the module is
importable while the original prose is preserved in docs/converted.
"""

from pathlib import Path


def get_notes() -> str:
    repo_root = Path(__file__).resolve().parent.parent
    p = repo_root / 'docs' / 'converted' / 'qmoi__avatars.md'
    if p.exists():
        return p.read_text(encoding='utf-8')
    return ''


__all__ = ['get_notes']




---

🌍 3. Specify Environment and World Details

Give the AI context for background, lighting, and props.

> “Generate an immersive environment with a semi-realistic lighting setup (HDRI-based), dynamic shadows, and atmospheric effects like fog or ambient particles. Include interactive props such as doors, surfaces, and foliage that react to the character’s movement or environment triggers.”




---

🧩 4. Animation & Movement Instructions

Guide the AI on how the character should move or express emotion.

> “Implement advanced IK/FK rigging with support for motion capture or keyframe animation. Facial rig should include 50+ blend shapes for expressive emotions. Movements should be fluid, weighty, and context-aware—e.g., clothes should sway naturally, hair should bounce, foot contact should trigger proper grounding.”




---

🧠 5. Include AI Optimization Instructions

If the AI app supports learning or procedural generation, guide it.

> “Train the character behavior on real human motion capture data for natural locomotion. Prioritize smooth transitions between animations. Use procedural animation where applicable to adapt to dynamic gameplay or narrative environments.”




---

🧾 6. Final Summary (for AI Input Prompt)

Here’s how this might look in a single AI prompt:


---

✅ Example Final AI Input:

> “Design a cinematic-quality 3D avatar with realistic facial structure, high-res skin textures, and strand-based dynamic hair. Body should follow true human anatomy with rig-ready topology and natural joint deformations. Outfit includes leather jacket, cloth pants, and metal accessories, each with physics-based interaction and PBR shaders. Environment should be semi-realistic urban with dynamic lighting, fog, and particle effects. Implement full-body rigging with facial blend shapes for emotion, compatible with mocap or hand-keyed animation. All assets should be optimized for smooth animation playback and responsive interaction with dynamic props.”




---

Would you like help writing a full prompt for a specific character or scene you're working on?

