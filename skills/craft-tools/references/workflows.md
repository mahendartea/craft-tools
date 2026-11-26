# Workflows

## 1. Vector poster → animated motion piece

This is the flagship workflow: build a vector poster in VectorCraft, then animate
its layers in EffectCraft.

### VectorCraft

1. Create an artboard (for example 1200 × 800) and build the poster from live
   shapes, paths, gradients, effects, and text.
2. Save the `.vectorcraft` file.
3. Export the layers as separate transparent PNGs. In MCP:

   ```text
   select.set { ids: [ ... ] }
   document.exportSelection {
     path: "assets/sun@2x.png",
     format: "png",
     scale: 2,
     background: "transparent"
   }
   ```

   The reply includes `bounds`; keep it for placement.
4. Useful groups: background, sun/glow, mountains, stars, title, copy.
5. Verify each PNG has an alpha channel. An RGB export will show a white box in
   the next app.

### EffectCraft

1. Create a comp matching the artboard: 1200 × 800, 30 fps, 5 s.
2. Import each PNG and add it as a layer, in this order: background → sun →
   mountains → stars → copy → title.
3. Place each layer at the center of its VectorCraft bounds, then set scale to
   50% because the assets are 2×.
4. Animate:

   - Background: scale 50% → 53%, slight position drift.
   - Sun: scale 50% → 52.5% → 50%, slight drift.
   - Mountains: scale 50% → 51%, position drift for parallax.
   - Stars: opacity 55 → 90 → 65.
   - Copy: opacity 0 → 100 and slide up.
   - Title: opacity 0 → 100, slide up, scale 48% → 50%.
   - Optional: black solid fade-in 100 → 0 in the first 0.8 s.

5. Render H.264 for the master and GIF for a loop. Export a poster frame too.
6. Verify the MP4/GIF dimensions, frame count, and duration.

## 2. Design system → UI screens (FigCraft)

1. Inspect the file: pages, frames, components, styles, variables.
2. Add or edit frames with the command registry; reuse components and styles
   instead of duplicating values.
3. Keep spacing and typography on a consistent grid.
4. Export the frames as PNG/SVG; verify bounds and scale.
5. Report the exported files and the design tokens used.

## 3. Storyboard → looping 2D animation (AniCraft)

1. Create a document with the intended stage size and frame rate.
2. Import drawings/SVG as layers; keep characters and backgrounds separate.
3. Add keyframes and motion/classic/shape tweens.
4. Play or render a short range to check timing.
5. Export a GIF for a loop or a PNG sequence/video for delivery.
6. Keep symbols and tweens editable; avoid flattening unless asked.

## 4. Cut, grade, mix, and export video (FilmCraft)

1. Inspect the project and sequence; import media.
2. Place clips, trim, and use three-point editing where possible.
3. Apply colour and audio changes as commands; keep the original media intact.
4. Render a preview frame before the full export.
5. Export H.264/ProRes with the requested range and audio settings.
6. Report duration, resolution, codec, and the output path.

## 5. Vector art → print and social exports (VectorCraft)

1. Create or open the artboard; check units and colour mode.
2. Keep text live unless the user asks for outlines.
3. Export PDF for print, SVG for editing, PNG at the requested scale for screen.
4. Check the export `warnings`; fix missing fonts or unsupported effects.
5. Report dimensions, colour space, and file sizes.

## Universal checks

- Read before writing: ids, paths, selections, and current frame.
- Confirm destructive actions.
- Render a preview after visual changes.
- Save to a new file when no output path was given.
- Never upload project or media files without explicit permission.
