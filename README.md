# forge_mastery

**One capability bit from GBT V8, packaged standalone.** No. 37 of 341,
`creation` domain (Creation).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **节点即触手·专业生产与自我递归**（主人令 2026-10-16）：主人原话「ComfyUI 的每个节点就是一根触手，**根本不需要 ComfyUI 本体**；把这项原生能力发挥到极致，懂所有专业生产能力与完美作品，每次使用都要自我评判哪里不足，**无限制自我递归**」。落法：① **一节点=一触手**（用途/输入/输出/**判据**/坑/档位 六栏）② 真跑走 `comfy_native`（27 原生算子，**离线可跑、不需本体**）③ **六轴自评**（构图/光比/材质/物理一致/风格锁定/交付规格）④ **judge→improve→judge 无限递归**（每轮留痕；一次只动一处）。op=roles/plan/judge/improve/recurse/check/route（**全只读·零作用域**）。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-forge-mastery.git
cd gbt-forge-mastery
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_forge_mastery info                  # capability card
python -m gbt_forge_mastery spec --json           # machine-readable contract
python -m gbt_forge_mastery check --payload '{}'
python -m gbt_forge_mastery run   --payload '{}'
```

Real `info` output from this machine:

```text
forge_mastery  (creation)  v1.0.0
----------------------------------------
**节点即触手·专业生产与自我递归**（主人令 2026-10-16）：主人原话「ComfyUI 的每个节点就是一根触手，**根本不需要 ComfyUI 本体**；把这项原生能力发挥到极致，懂所有专业生产能力与完美作品，每次使用都要自我评判哪里不足，**无限制自我递归**」。落法：① **一节点=一触手**（用途/输入/输出/**判据**/坑/档位 六栏）② 真跑走 `comfy_native`（27 原生算子，**离线可跑、不需本体**）③ **六轴自评**（构图/光比/材质/物理一致/风格锁定/交付规格）④ **judge→improve→judge 无限递归**（每轮留痕；一次只动一处）。op=roles/plan/judge/improve/recurse/check/route（**全只读·零作用域**）。

gated      : True   <- needs explicit consent
external   : False
multi-op   : True
params     : (none)
values     : roles, plan, judge, improve, recurse, check, route
```

Wire a real implementation:

```python
from gbt_forge_mastery import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（7 个）**：`roles`、`plan`、`judge`、`improve`、`recurse`、`check`、`route`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.13s
```

## Provenance

| field | value |
|---|---|
| capability | `forge_mastery` |
| domain | `creation` |
| handler | `forge_mastery` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [creation/forge_mastery](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/creation/forge_mastery.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
